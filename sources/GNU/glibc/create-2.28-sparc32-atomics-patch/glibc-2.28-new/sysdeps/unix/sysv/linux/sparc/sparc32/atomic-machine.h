/* Atomic operations.  SPARC/Linux version.
   Copyright (C) 2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library.  If not, see
   <http://www.gnu.org/licenses/>.  */

#include <stdint.h>

#define __sparc_assisted_compare_and_exchange_val_32_acq(mem, newval, oldval)\
({union { __typeof (oldval) a; uint32_t v; } oldval_arg = { .a = (oldval) }; \
  union { __typeof (newval) a; uint32_t v; } newval_arg = { .a = (newval) }; \
  register uint32_t __acev_tmp __asm ("%o2");	            \
  register __typeof (mem) __acev_mem __asm ("%o0") = (mem);	    \
  register uint32_t __acev_oldval __asm ("%o1");	            \
  __acev_tmp = newval_arg.v;	    \
  __acev_oldval = oldval_arg.v;	    \
  __asm __volatile ("ta 0x23"	            \
	   : "+r" (__acev_tmp), "=m" (*__acev_mem)	    \
	   : "r" (__acev_oldval), "m" (*__acev_mem),	    \
	     "r" (__acev_mem) : "memory");	    \
  (__typeof (oldval)) __acev_tmp; })

#include <sysdeps/sparc/sparc32/atomic-machine.h>
