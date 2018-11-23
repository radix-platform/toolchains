

COMPONENT_TARGETS = $(TOOLCHAIN_X86_64_GLIBC)

FLAVOURS = headers full

include ../../../build-system/config.mk

SOURCE_REQUIRES = sources/GNU/glibc

ifeq ($(FLAVOUR),headers)
REQUIRES  = core/linux/4.19.3
endif

ifeq ($(FLAVOUR),full)
REQUIRES  = core/gcc/6.5.0^second
endif

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/GNU/glibc/glibc-2.27.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/glibc-2.27
src_dir_name    = glibc-2.27
src_done        = $(TARGET_BUILD_DIR)/.source-done

PATCHES         = PATCHES

full_dir        = $(TARGET_BUILD_DIR)/build-full
headers_dir     = $(TARGET_BUILD_DIR)/build-headers

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed
full_target     = $(TARGET_BUILD_DIR)/.installed



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(full_target)
endif

include ../../../build-system/core.mk


env_sysroot     = install_root=$(sysroot_dir)


CC           = $(CCACHE)$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc -m32

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC="$(CC)"
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)

environment += BUILD_CC="$(CCACHE)/usr/bin/gcc"

LIBSUFFIX    =

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC))
environment += CFLAGS="-g -O3 -march=i686 -mtune=i686"
LIBSUFFIX    = 32
endif

TARGET32 = $(shell echo $(TARGET) | sed 's/x86_64/i686/')


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(headers_target): $(src_done)
	@mkdir -p $(headers_dir)
	@cd $(headers_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET32)           \
	  $(extra_configure_switches)
	@cd $(headers_dir) && $(MAKE) -j1 install-headers \
	                                  install-bootstrap-headers=yes $(env_sysroot)
	@cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_lib
	# ======= install 'lib-names-32.h' =======
	@mkdir -p $(sysroot_dir)/usr/include/gnu
	@install --mode=0644 $(headers_dir)/gnu/lib-names-32.h $(sysroot_dir)/usr/include/gnu
	# ========================================
	@cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_install $(env_sysroot)
	@$(environment) $(CC) -nostdlib -nostartfiles -shared -x c /dev/null \
	                      -o $(sysroot_dir)/usr/lib$(LIBSUFFIX)/libc.so
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@

$(full_target): $(src_done)
	@mkdir -p $(full_dir)
	@echo "slibdir=/lib$(LIBSUFFIX)" >> $(full_dir)/configparms
	@cd $(full_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET32)           \
	  $(extra_configure_switches)
	@cd $(full_dir) && $(environment) $(MAKE) all
	@cd $(full_dir) && $(environment) $(MAKE) -j1 install $(env_sysroot)
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
