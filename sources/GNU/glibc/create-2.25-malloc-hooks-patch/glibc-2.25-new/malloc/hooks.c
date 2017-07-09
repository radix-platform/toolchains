/* Malloc implementation for multiple threads without lock contention.
   Copyright (C) 2001-2017 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Wolfram Gloger <wg@malloc.de>, 2001.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public License as
   published by the Free Software Foundation; either version 2.1 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If
   not, see <http://www.gnu.org/licenses/>.  */

/* What to do if the standard debugging hooks are in place and a
   corrupt pointer is detected: do nothing (0), print an error message
   (1), or call abort() (2). */

/* Hooks for debugging versions.  The initial hooks just call the
   initialization routine, then do the normal work. */

static void *
malloc_hook_ini (size_t sz, const void *caller)
{
  __malloc_hook = NULL;
  ptmalloc_init ();
  return __libc_malloc (sz);
}

static void *
realloc_hook_ini (void *ptr, size_t sz, const void *caller)
{
  __malloc_hook = NULL;
  __realloc_hook = NULL;
  ptmalloc_init ();
  return __libc_realloc (ptr, sz);
}

static void *
memalign_hook_ini (size_t alignment, size_t sz, const void *caller)
{
  __memalign_hook = NULL;
  ptmalloc_init ();
  return __libc_memalign (alignment, sz);
}

/* Whether we are using malloc checking.  */
static int using_malloc_checking;

/* A flag that is set by malloc_set_state, to signal that malloc checking
   must not be enabled on the request from the user (via the MALLOC_CHECK_
   environment variable).  It is reset by __malloc_check_init to tell
   malloc_set_state that the user has requested malloc checking.

   The purpose of this flag is to make sure that malloc checking is not
   enabled when the heap to be restored was constructed without malloc
   checking, and thus does not contain the required magic bytes.
   Otherwise the heap would be corrupted by calls to free and realloc.  If
   it turns out that the heap was created with malloc checking and the
   user has requested it malloc_set_state just calls __malloc_check_init
   again to enable it.  On the other hand, reusing such a heap without
   further malloc checking is safe.  */
static int disallow_malloc_check;

/* Activate a standard set of debugging hooks. */
void
__malloc_check_init (void)
{
  if (disallow_malloc_check)
    {
      disallow_malloc_check = 0;
      return;
    }
  using_malloc_checking = 1;
  __malloc_hook = malloc_check;
  __free_hook = free_check;
  __realloc_hook = realloc_check;
  __memalign_hook = memalign_check;
}

/* A simple, standard set of debugging hooks.  Overhead is `only' one
   byte per chunk; still this will catch most cases of double frees or
   overruns.  The goal here is to avoid obscure crashes due to invalid
   usage, unlike in the MALLOC_DEBUG code. */

static unsigned char
magicbyte (const void *p)
{
  unsigned char magic;

  magic = (((uintptr_t) p >> 3) ^ ((uintptr_t) p >> 11)) & 0xFF;
  /* Do not return 1.  See the comment in mem2mem_check().  */
  if (magic == 1)
    ++magic;
  return magic;
}


/* Visualize the chunk as being partitioned into blocks of 255 bytes from the
   highest address of the chunk, downwards.  The end of each block tells
   us the size of that block, up to the actual size of the requested
   memory.  Our magic byte is right at the end of the requested size, so we
   must reach it with this iteration, otherwise we have witnessed a memory
   corruption.  */
static size_t
malloc_check_get_size (mchunkptr p)
{
  size_t size;
  unsigned char c;
  unsigned char magic = magicbyte (p);

  assert (using_malloc_checking == 1);

  for (size = chunksize (p) - 1 + (chunk_is_mmapped (p) ? 0 : SIZE_SZ);
       (c = ((unsigned char *) p)[size]) != magic;
       size -= c)
    {
      if (c <= 0 || size < (c + 2 * SIZE_SZ))
        {
          malloc_printerr (check_action, "malloc_check_get_size: memory corruption",
                           chunk2mem (p),
			   chunk_is_mmapped (p) ? NULL : arena_for_chunk (p));
          return 0;
        }
    }

  /* chunk2mem size.  */
  return size - 2 * SIZE_SZ;
}

/* Instrument a chunk with overrun detector byte(s) and convert it
   into a user pointer with requested size req_sz. */

static void *
internal_function
mem2mem_check (void *ptr, size_t req_sz)
{
  mchunkptr p;
  unsigned char *m_ptr = ptr;
  size_t max_sz, block_sz, i;
  unsigned char magic;

  if (!ptr)
    return ptr;

  p = mem2chunk (ptr);
  magic = magicbyte (p);
  max_sz = chunksize (p) - 2 * SIZE_SZ;
  if (!chunk_is_mmapped (p))
    max_sz += SIZE_SZ;
  for (i = max_sz - 1; i > req_sz; i -= block_sz)
    {
      block_sz = MIN (i - req_sz, 0xff);
      /* Don't allow the magic byte to appear in the chain of length bytes.
         For the following to work, magicbyte cannot return 0x01.  */
      if (block_sz == magic)
        --block_sz;

      m_ptr[i] = block_sz;
    }
  m_ptr[req_sz] = magic;
  return (void *) m_ptr;
}

/* Convert a pointer to be free()d or realloc()ed to a valid chunk
   pointer.  If the provided pointer is not valid, return NULL. */

static mchunkptr
internal_function
mem2chunk_check (void *mem, unsigned char **magic_p)
{
  mchunkptr p;
  INTERNAL_SIZE_T sz, c;
  unsigned char magic;

  if (!aligned_OK (mem))
    return NULL;

  p = mem2chunk (mem);
  sz = chunksize (p);
  magic = magicbyte (p);
  if (!chunk_is_mmapped (p))
    {
      /* Must be a chunk in conventional heap memory. */
      int contig = contiguous (&main_arena);
      if ((contig &&
           ((char *) p < mp_.sbrk_base ||
            ((char *) p + sz) >= (mp_.sbrk_base + main_arena.system_mem))) ||
          sz < MINSIZE || sz & MALLOC_ALIGN_MASK || !inuse (p) ||
          (!prev_inuse (p) && ((prev_size (p) & MALLOC_ALIGN_MASK) != 0 ||
                               (contig && (char *) prev_chunk (p) < mp_.sbrk_base) ||
                               next_chunk (prev_chunk (p)) != p)))
        return NULL;

      for (sz += SIZE_SZ - 1; (c = ((unsigned char *) p)[sz]) != magic; sz -= c)
        {
          if (c == 0 || sz < (c + 2 * SIZE_SZ))
            return NULL;
        }
    }
  else
    {
      unsigned long offset, page_mask = GLRO (dl_pagesize) - 1;

      /* mmap()ed chunks have MALLOC_ALIGNMENT or higher power-of-two
         alignment relative to the beginning of a page.  Check this
         first. */
      offset = (unsigned long) mem & page_mask;
      if ((offset != MALLOC_ALIGNMENT && offset != 0 && offset != 0x10 &&
           offset != 0x20 && offset != 0x40 && offset != 0x80 && offset != 0x100 &&
           offset != 0x200 && offset != 0x400 && offset != 0x800 && offset != 0x1000 &&
           offset < 0x2000) ||
          !chunk_is_mmapped (p) || prev_inuse (p) ||
          ((((unsigned long) p - prev_size (p)) & page_mask) != 0) ||
          ((prev_size (p) + sz) & page_mask) != 0)
        return NULL;

      for (sz -= 1; (c = ((unsigned char *) p)[sz]) != magic; sz -= c)
        {
          if (c == 0 || sz < (c + 2 * SIZE_SZ))
            return NULL;
        }
    }
  ((unsigned char *) p)[sz] ^= 0xFF;
  if (magic_p)
    *magic_p = (unsigned char *) p + sz;
  return p;
}

/* Check for corruption of the top chunk, and try to recover if
   necessary. */

static int
internal_function
top_check (void)
{
  mchunkptr t = top (&main_arena);
  char *brk, *new_brk;
  INTERNAL_SIZE_T front_misalign, sbrk_size;
  unsigned long pagesz = GLRO (dl_pagesize);

  if (t == initial_top (&main_arena) ||
      (!chunk_is_mmapped (t) &&
       chunksize (t) >= MINSIZE &&
       prev_inuse (t) &&
       (!contiguous (&main_arena) ||
        (char *) t + chunksize (t) == mp_.sbrk_base + main_arena.system_mem)))
    return 0;

  malloc_printerr (check_action, "malloc: top chunk is corrupt", t,
		   &main_arena);

  /* Try to set up a new top chunk. */
  brk = MORECORE (0);
  front_misalign = (unsigned long) chunk2mem (brk) & MALLOC_ALIGN_MASK;
  if (front_misalign > 0)
    front_misalign = MALLOC_ALIGNMENT - front_misalign;
  sbrk_size = front_misalign + mp_.top_pad + MINSIZE;
  sbrk_size += pagesz - ((unsigned long) (brk + sbrk_size) & (pagesz - 1));
  new_brk = (char *) (MORECORE (sbrk_size));
  if (new_brk == (char *) (MORECORE_FAILURE))
    {
      __set_errno (ENOMEM);
      return -1;
    }
  /* Call the `morecore' hook if necessary.  */
  void (*hook) (void) = atomic_forced_read (__after_morecore_hook);
  if (hook)
    (*hook)();
  main_arena.system_mem = (new_brk - mp_.sbrk_base) + sbrk_size;

  top (&main_arena) = (mchunkptr) (brk + front_misalign);
  set_head (top (&main_arena), (sbrk_size - front_misalign) | PREV_INUSE);

  return 0;
}

static void *
malloc_check (size_t sz, const void *caller)
{
  void *victim;

  if (sz + 1 == 0)
    {
      __set_errno (ENOMEM);
      return NULL;
    }

  __libc_lock_lock (main_arena.mutex);
  victim = (top_check () >= 0) ? _int_malloc (&main_arena, sz + 1) : NULL;
  __libc_lock_unlock (main_arena.mutex);
  return mem2mem_check (victim, sz);
}

static void
free_check (void *mem, const void *caller)
{
  mchunkptr p;

  if (!mem)
    return;

  __libc_lock_lock (main_arena.mutex);
  p = mem2chunk_check (mem, NULL);
  if (!p)
    {
      __libc_lock_unlock (main_arena.mutex);

      malloc_printerr (check_action, "free(): invalid pointer", mem,
		       &main_arena);
      return;
    }
  if (chunk_is_mmapped (p))
    {
      __libc_lock_unlock (main_arena.mutex);
      munmap_chunk (p);
      return;
    }
  _int_free (&main_arena, p, 1);
  __libc_lock_unlock (main_arena.mutex);
}

static void *
realloc_check (void *oldmem, size_t bytes, const void *caller)
{
  INTERNAL_SIZE_T nb;
  void *newmem = 0;
  unsigned char *magic_p = NULL;

  if (bytes + 1 == 0)
    {
      __set_errno (ENOMEM);
      return NULL;
    }
  if (oldmem == 0)
    return malloc_check (bytes, NULL);

  if (bytes == 0)
    {
      free_check (oldmem, NULL);
      return NULL;
    }
  __libc_lock_lock (main_arena.mutex);
  const mchunkptr oldp = mem2chunk_check (oldmem, &magic_p);
  __libc_lock_unlock (main_arena.mutex);
  if (!oldp)
    {
      malloc_printerr (check_action, "realloc(): invalid pointer", oldmem,
		       &main_arena);
      return malloc_check (bytes, NULL);
    }
  const INTERNAL_SIZE_T oldsize = chunksize (oldp);

  checked_request2size (bytes + 1, nb);
  __libc_lock_lock (main_arena.mutex);

  if (chunk_is_mmapped (oldp))
    {
#if HAVE_MREMAP
      mchunkptr newp = mremap_chunk (oldp, nb);
      if (newp)
        newmem = chunk2mem (newp);
      else
#endif
      {
        /* Note the extra SIZE_SZ overhead. */
        if (oldsize - SIZE_SZ >= nb)
          newmem = oldmem; /* do nothing */
        else
          {
            /* Must alloc, copy, free. */
            if (top_check () >= 0)
              newmem = _int_malloc (&main_arena, bytes + 1);
            if (newmem)
              {
                memcpy (newmem, oldmem, oldsize - 2 * SIZE_SZ);
                munmap_chunk (oldp);
              }
          }
      }
    }
  else
    {
      if (top_check () >= 0)
        {
          INTERNAL_SIZE_T nb;
          checked_request2size (bytes + 1, nb);
          newmem = _int_realloc (&main_arena, oldp, oldsize, nb);
        }
    }

  /* mem2chunk_check changed the magic byte in the old chunk.
     If newmem is NULL, then the old chunk will still be used though,
     so we need to invert that change here.  */
  if (newmem == NULL)
    *magic_p ^= 0xFF;

  __libc_lock_unlock (main_arena.mutex);

  return mem2mem_check (newmem, bytes);
}

static void *
memalign_check (size_t alignment, size_t bytes, const void *caller)
{
  void *mem;

  if (alignment <= MALLOC_ALIGNMENT)
    return malloc_check (bytes, NULL);

  if (alignment < MINSIZE)
    alignment = MINSIZE;

  /* If the alignment is greater than SIZE_MAX / 2 + 1 it cannot be a
     power of 2 and will cause overflow in the check below.  */
  if (alignment > SIZE_MAX / 2 + 1)
    {
      __set_errno (EINVAL);
      return 0;
    }

  /* Check for overflow.  */
  if (bytes > SIZE_MAX - alignment - MINSIZE)
    {
      __set_errno (ENOMEM);
      return 0;
    }

  /* Make sure alignment is power of 2.  */
  if (!powerof2 (alignment))
    {
      size_t a = MALLOC_ALIGNMENT * 2;
      while (a < alignment)
        a <<= 1;
      alignment = a;
    }

  __libc_lock_lock (main_arena.mutex);
  mem = (top_check () >= 0) ? _int_memalign (&main_arena, alignment, bytes + 1) :
        NULL;
  __libc_lock_unlock (main_arena.mutex);
  return mem2mem_check (mem, bytes);
}

#if SHLIB_COMPAT (libc, GLIBC_2_0, GLIBC_2_25)

/* Get/set state: malloc_get_state() records the current state of all
   malloc variables (_except_ for the actual heap contents and `hook'
   function pointers) in a system dependent, opaque data structure.
   This data structure is dynamically allocated and can be free()d
   after use.  malloc_set_state() restores the state of all malloc
   variables to the previously obtained state.  This is especially
   useful when using this malloc as part of a shared library, and when
   the heap contents are saved/restored via some other method.  The
   primary example for this is GNU Emacs with its `dumping' procedure.
   `Hook' function pointers are never saved or restored by these
   functions, with two exceptions: If malloc checking was in use when
   malloc_get_state() was called, then malloc_set_state() calls
   __malloc_check_init() if possible; if malloc checking was not in
   use in the recorded state but the user requested malloc checking,
   then the hooks are reset to 0.  */

#define MALLOC_STATE_MAGIC   0x444c4541l
#define MALLOC_STATE_VERSION (0 * 0x100l + 5l) /* major*0x100 + minor */

struct malloc_save_state
{
  long magic;
  long version;
  mbinptr av[NBINS * 2 + 2];
  char *sbrk_base;
  int sbrked_mem_bytes;
  unsigned long trim_threshold;
  unsigned long top_pad;
  unsigned int n_mmaps_max;
  unsigned long mmap_threshold;
  int check_action;
  unsigned long max_sbrked_mem;
  unsigned long max_total_mem;	/* Always 0, for backwards compatibility.  */
  unsigned int n_mmaps;
  unsigned int max_n_mmaps;
  unsigned long mmapped_mem;
  unsigned long max_mmapped_mem;
  int using_malloc_checking;
  unsigned long max_fast;
  unsigned long arena_test;
  unsigned long arena_max;
  unsigned long narenas;
};

/* Dummy implementation which always fails.  We need to provide this
   symbol so that existing Emacs binaries continue to work with
   BIND_NOW.  */
void *
attribute_compat_text_section
malloc_get_state (void)
{
  __set_errno (ENOSYS);
  return NULL;
}
compat_symbol (libc, malloc_get_state, malloc_get_state, GLIBC_2_0);

int
attribute_compat_text_section
malloc_set_state (void *msptr)
{
  struct malloc_save_state *ms = (struct malloc_save_state *) msptr;

  if (ms->magic != MALLOC_STATE_MAGIC)
    return -1;

  /* Must fail if the major version is too high. */
  if ((ms->version & ~0xffl) > (MALLOC_STATE_VERSION & ~0xffl))
    return -2;

  /* We do not need to perform locking here because __malloc_set_state
     must be called before the first call into the malloc subsytem
     (usually via __malloc_initialize_hook).  pthread_create always
     calls calloc and thus must be called only afterwards, so there
     cannot be more than one thread when we reach this point.  */

  /* Disable the malloc hooks (and malloc checking).  */
  __malloc_hook = NULL;
  __realloc_hook = NULL;
  __free_hook = NULL;
  __memalign_hook = NULL;
  using_malloc_checking = 0;

  /* Patch the dumped heap.  We no longer try to integrate into the
     existing heap.  Instead, we mark the existing chunks as mmapped.
     Together with the update to dumped_main_arena_start and
     dumped_main_arena_end, realloc and free will recognize these
     chunks as dumped fake mmapped chunks and never free them.  */

  /* Find the chunk with the lowest address with the heap.  */
  mchunkptr chunk = NULL;
  {
    size_t *candidate = (size_t *) ms->sbrk_base;
    size_t *end = (size_t *) (ms->sbrk_base + ms->sbrked_mem_bytes);
    while (candidate < end)
      if (*candidate != 0)
	{
	  chunk = mem2chunk ((void *) (candidate + 1));
	  break;
	}
      else
	++candidate;
  }
  if (chunk == NULL)
    return 0;

  /* Iterate over the dumped heap and patch the chunks so that they
     are treated as fake mmapped chunks.  */
  mchunkptr top = ms->av[2];
  while (chunk < top)
    {
      if (inuse (chunk))
	{
	  /* Mark chunk as mmapped, to trigger the fallback path.  */
	  size_t size = chunksize (chunk);
	  set_head (chunk, size | IS_MMAPPED);
	}
      chunk = next_chunk (chunk);
    }

  /* The dumped fake mmapped chunks all lie in this address range.  */
  dumped_main_arena_start = (mchunkptr) ms->sbrk_base;
  dumped_main_arena_end = top;

  return 0;
}
compat_symbol (libc, malloc_set_state, malloc_set_state, GLIBC_2_0);

#endif	/* SHLIB_COMPAT */

/*
 * Local variables:
 * c-basic-offset: 2
 * End:
 */
