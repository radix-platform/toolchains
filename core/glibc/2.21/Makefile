

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I486_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)

FLAVOURS = headers full

include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/GNU/glibc

tar_xz_archive  = $(SRC_PACKAGE_DIR)/GNU/glibc/glibc-2.21.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/glibc-2.21
src_dir_name    = glibc-2.21
src_done        = $(TARGET_BUILD_DIR)/.source-done

PATCHES         = PATCHES

full_dir        = $(TARGET_BUILD_DIR)/build-full
headers_dir     = $(TARGET_BUILD_DIR)/build-headers

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed
full_target     = $(TARGET_BUILD_DIR)/.installed

env_sysroot     = install_root=$(sysroot_dir)


CC           = $(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC="$(CC)"
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)

environment += BUILD_CC=gcc

LIBSUFFIX    =

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7ve -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_IMX6_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7-a -mtune=cortex-a9 -mfpu=vfpv3-d16 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7-a -mtune=cortex-a15 -mfpu=neon-vfpv4 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_GLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_GLIBC))
environment += CFLAGS="-g -O2"
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_I486_GLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC))
environment += CFLAGS="-g -O2"
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC)      \
                             $(TOOLCHAIN_A2X_GLIBC)      \
                             $(TOOLCHAIN_IMX6_GLIBC)     \
                             $(TOOLCHAIN_OMAP35X_GLIBC)  \
                             $(TOOLCHAIN_OMAP543X_GLIBC) \
                             $(TOOLCHAIN_X86_64_GLIBC)),)
LIB_NAMES_SUFFIX = hard
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_DM644X_GLIBC)),)
LIB_NAMES_SUFFIX = soft
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_GLIBC))
LIB_NAMES_SUFFIX = o32_hard
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_I486_GLIBC))
LIB_NAMES_SUFFIX = 32
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC))
LIB_NAMES_SUFFIX = 64
endif



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(full_target)
endif

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_IMX6_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.35
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.35
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_GLIBC))
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_GLIBC))
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-fp
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-fp
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_GLIBC))
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_I486_GLIBC))
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
	mkdir -p $(headers_dir)
	cd $(headers_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET)             \
	  $(extra_configure_switches)
	cd $(headers_dir) && $(MAKE) -j1 install-headers \
	                                 install-bootstrap-headers=yes $(env_sysroot)
	cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_lib
	# ======= install 'lib-names-$(LIB_NAMES_SUFFIX).h' =======
	mkdir -p $(sysroot_dir)/usr/include/gnu
	install --mode=0644 $@/gnu/lib-names-$(LIB_NAMES_SUFFIX).h $(sysroot_dir)/usr/include/gnu
	install --mode=0644 $(SRC_DIR)/include/gnu/stubs.h $(sysroot_dir)/usr/include/gnu
	# =========================================================
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
	  --host=$(TARGET)             \
	  $(extra_configure_switches)
	cd $(full_dir) && $(environment) $(MAKE) all
	cd $(full_dir) && $(environment) $(MAKE) -j1 install $(env_sysroot)
	rm -f $(sysroot_dir)/usr/share/info/dir
	@touch $@
