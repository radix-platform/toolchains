
COMPONENT_TARGETS = $(TOOLCHAIN_X86_64_EGLIBC)

FLAVOURS = headers full

include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/GNU/EGLIBC/2.18.1

tar_bz2_archive       = $(SRC_PACKAGE_DIR)/GNU/EGLIBC/2.18.1/eglibc-2.18.1.tar.bz2
full_dir              = $(TARGET_BUILD_DIR)/build-full
headers_dir           = $(TARGET_BUILD_DIR)/build-headers

sysroot_dir  = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

src_done     = $(TARGET_BUILD_DIR)/.source-done
src_dir_name = eglibc-2.18.1
SRC_DIR      = $(TARGET_BUILD_DIR)/eglibc-2.18.1
SRC_ARCHIVE  = $(tar_bz2_archive)
PATCHES      = PATCHES

install_target = $(TARGET_BUILD_DIR)/.installed
headers_target = $(TARGET_BUILD_DIR)/.headers-installed

env_sysroot  = install_root=$(sysroot_dir)


CC           = $(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc -m32

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC="$(CC)"
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)

environment += BUILD_CC=gcc

LIBSUFFIX    =

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
environment += CFLAGS="-g -O3 -march=i486 -mtune=i686"
LIBSUFFIX    = 32
endif

TARGET32 = $(shell echo $(TARGET) | sed 's/x86_64/i486/')


ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(install_target)
endif

include ../../../build-system/core.mk


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


.PHONY: headers_install full_install


$(headers_target): headers_install
	@touch $@

$(install_target): full_install
	@touch $@

$(SRC_DIR): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(src_done): $(SRC_DIR)
	touch $@

$(headers_dir): $(src_done)
	mkdir -p $@
	cd $@ && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET32)           \
	  $(extra_configure_switches)
	cd $@ && $(MAKE) install-headers \
	                 install-bootstrap-headers=yes $(env_sysroot)
	cd $@ && $(environment) $(MAKE) csu/subdir_lib
	cd $@ && $(environment) $(MAKE) csu/subdir_install $(env_sysroot)
	$(environment) $(CC) -nostdlib -nostartfiles -shared -x c /dev/null \
	                     -o $(sysroot_dir)/usr/lib$(LIBSUFFIX)/libc.so

headers_install: $(headers_dir)

$(full_dir): $(src_done)
	mkdir -p $@
	echo "slibdir=/lib$(LIBSUFFIX)" >> $@/configparms
	cd $@ && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET32)           \
	  $(extra_configure_switches)
	cd $@ && $(environment) $(MAKE) all install $(env_sysroot)

full_install: $(full_dir)