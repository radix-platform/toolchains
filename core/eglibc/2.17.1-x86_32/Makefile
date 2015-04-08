
COMPONENT_TARGETS = $(TOOLCHAIN_X86_64_EGLIBC)

FLAVOURS = headers full

include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/GNU/EGLIBC/2.17.1

tar_bz2_archive       = $(SRC_PACKAGE_DIR)/GNU/EGLIBC/2.17.1/eglibc-2.17.1.tar.bz2
SRC_ARCHIVE           = $(tar_bz2_archive)
SRC_DIR               = $(TARGET_BUILD_DIR)/eglibc-2.17.1
src_dir_name          = eglibc-2.17.1
src_done              = $(TARGET_BUILD_DIR)/.source-done

PATCHES      = PATCHES

full_dir              = $(TARGET_BUILD_DIR)/build-full
headers_dir           = $(TARGET_BUILD_DIR)/build-headers

sysroot_dir           = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target        = $(TARGET_BUILD_DIR)/.headers-installed
full_target           = $(TARGET_BUILD_DIR)/.installed



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(full_target)
endif

include ../../../build-system/core.mk


env_sysroot  = install_root=$(sysroot_dir)


CC           = $(CCACHE)$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc -m32

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC="$(CC)"
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)

environment += BUILD_CC=$(CCACHE)/usr/bin/gcc

LIBSUFFIX    =

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
environment += CFLAGS="-g -O3 -march=i486 -mtune=i686"
LIBSUFFIX    = 32
endif

TARGET32 = $(shell echo $(TARGET) | sed 's/x86_64/i486/')


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
extra_configure_switches  += --enable-add-ons=libidn,nptl
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(headers_target): $(src_done)
	mkdir -p $(headers_dir)
	cd $(headers_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET32)           \
	  $(extra_configure_switches)
	cd $(headers_dir) && $(MAKE) -j1 install-headers \
	                                 install-bootstrap-headers=yes $(env_sysroot)
	cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_lib
	cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_install $(env_sysroot)
	$(environment) $(CC) -nostdlib -nostartfiles -shared -x c /dev/null \
	                     -o $(sysroot_dir)/usr/lib$(LIBSUFFIX)/libc.so
	@touch $@

$(full_target): $(src_done)
	mkdir -p $(full_dir)
	echo "slibdir=/lib$(LIBSUFFIX)" >> $(full_dir)/configparms
	cd $(full_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET32)           \
	  $(extra_configure_switches)
	cd $(full_dir) && $(environment) $(MAKE) all
	cd $(full_dir) && $(environment) $(MAKE) -j1 install $(env_sysroot)
	@touch $@
