

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_H3_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_H5_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_JZ47XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_P5600_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK328X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_S8XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_S9XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK33XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK339X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8LE_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9LE_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_R1000_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I686_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)

FLAVOURS = headers full

include ../../../build-system/config.mk

SOURCE_REQUIRES = sources/GNU/glibc

ifeq ($(FLAVOUR),headers)
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC))
REQUIRES  = core/linux/sunxi/sunxi-3.4-20140514
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC))
REQUIRES  = core/linux/sunxi/sunxi-3.4-20150315
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H3_GLIBC))
REQUIRES  = core/linux/FriendlyARM/H3/h3-4.14.52-20180918
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H5_GLIBC))
REQUIRES  = core/linux/FriendlyARM/H5/h5-4.14.52-20180628
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_IMX6_GLIBC))
REQUIRES  = core/linux/Freescale/Nit6Q/imx-3.14.28-20150320
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC))
REQUIRES  = core/linux/Ingenic/CI20/ci20-3.18-20160210
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC))
REQUIRES  = core/linux/Baikal/BFK/baikal-4.4.145-4.15.115
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_I686_GLIBC))
REQUIRES  = core/linux/4.19.3
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_GLIBC))
REQUIRES  = core/linux/TI/omap5/glsdk/3.14.57-20151211
endif
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_RK328X_GLIBC) \
                             $(TOOLCHAIN_RK33XX_GLIBC) \
                             $(TOOLCHAIN_RK339X_GLIBC) \
                             $(TOOLCHAIN_A33XX_GLIBC)),)
REQUIRES  = core/linux/Rockchip/v4.x/rk-4.4.154-20181101
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_GLIBC))
REQUIRES  = core/linux/Amlogic/M201/aml-3.10.33-20160716
endif
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S9XX_GLIBC) \
                             $(TOOLCHAIN_A9XX_GLIBC)),)
REQUIRES  = core/linux/Amlogic/P201/aml-3.14.29-20160818
endif
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC) \
                             $(TOOLCHAIN_POWER9_GLIBC)),)
REQUIRES  = core/glibc/2.28-ppc32^headers
endif
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8LE_GLIBC) \
                             $(TOOLCHAIN_POWER9LE_GLIBC)),)
REQUIRES  = core/linux/4.19.3
endif
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
REQUIRES  = core/glibc/2.28-sparc32^headers
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC))
REQUIRES  = core/glibc/2.28-x86_32^headers
endif
endif

ifeq ($(FLAVOUR),full)
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC))
REQUIRES  = core/glibc/2.28-x86_32^full
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC) \
                             $(TOOLCHAIN_POWER9_GLIBC)),)
REQUIRES  = core/glibc/2.28-ppc32^full
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
REQUIRES  = core/glibc/2.28-sparc32^full
else
REQUIRES  = core/gcc/8.2.0^second
endif
endif
endif
endif

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/GNU/glibc/glibc-2.28.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/glibc-2.28
src_dir_name    = glibc-2.28
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


CC           = $(CCACHE)$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC="$(CC)"
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)

environment += BUILD_CC="$(CCACHE)/usr/bin/gcc"

LIBSUFFIX    =

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7ve -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H3_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7ve -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H5_GLIBC))
environment += CFLAGS="-g -O3 -march=armv8-a -mcpu=cortex-a53 -mabi=lp64"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_IMX6_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7-a -mtune=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC))
environment += CFLAGS="-g -O2 -march=mips32r2 -mhard-float"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC))
environment += CFLAGS="-g -O2 -march=mips32r5 -mtune=p5600 -mhard-float"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7ve -mtune=cortex-a15 -mfpu=neon-vfpv4 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK328X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7ve -mtune=cortex-a17 -mfpu=neon-vfpv4 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_GLIBC))
environment += CFLAGS="-g -O3 -march=armv7-a -mtune=cortex-a5 -mfpu=neon -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S9XX_GLIBC))
environment += CFLAGS="-g -O3 -march=armv8-a -mcpu=cortex-a53 -mabi=lp64"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A9XX_GLIBC))
environment += CFLAGS="-g -O3 -march=armv8-a -mfpu=neon-fp-armv8 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK33XX_GLIBC))
environment += CFLAGS="-g -O3 -march=armv8-a -mcpu=cortex-a53 -mabi=lp64"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK339X_GLIBC))
environment += CFLAGS="-g -O3 -march=armv8-a -mcpu=cortex-a72.cortex-a53 -mabi=lp64"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A33XX_GLIBC))
environment += CFLAGS="-g -O3 -march=armv8-a -mfpu=neon-fp-armv8 -mfloat-abi=hard"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC))
environment += CFLAGS="-g -O3 -mcpu=power8 -mlong-double-128"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_POWER9_GLIBC))
environment += CFLAGS="-g -O3 -mcpu=power9 -mlong-double-128"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_POWER8LE_GLIBC))
environment += CFLAGS="-g -O3 -mcpu=power8 -mlong-double-128"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_POWER9LE_GLIBC))
environment += CFLAGS="-g -O3 -mcpu=power9 -mlong-double-128"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC))
environment += CFLAGS="-g -O3 -mcpu=ultrasparc3 -mhard-float -mlong-double-128 -mglibc"
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_I686_GLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC))
environment += CFLAGS="-g -O2"
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC)      \
                             $(TOOLCHAIN_A2X_GLIBC)      \
                             $(TOOLCHAIN_H3_GLIBC)       \
                             $(TOOLCHAIN_IMX6_GLIBC)     \
                             $(TOOLCHAIN_OMAP543X_GLIBC) \
                             $(TOOLCHAIN_RK328X_GLIBC)   \
                             $(TOOLCHAIN_S8XX_GLIBC)     \
                             $(TOOLCHAIN_A9XX_GLIBC)     \
                             $(TOOLCHAIN_A33XX_GLIBC)),)
LIB_NAMES_SUFFIX = hard
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC) $(TOOLCHAIN_P5600_GLIBC)),)
LIB_NAMES_SUFFIX = o32_hard
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S9XX_GLIBC)   \
                             $(TOOLCHAIN_H5_GLIBC)     \
                             $(TOOLCHAIN_RK33XX_GLIBC) \
                             $(TOOLCHAIN_RK339X_GLIBC)),)
LIB_NAMES_SUFFIX = lp64
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_I686_GLIBC))
LIB_NAMES_SUFFIX = 32
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC) $(TOOLCHAIN_POWER9_GLIBC)),)
LIB_NAMES_SUFFIX = 64-v1
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8LE_GLIBC) $(TOOLCHAIN_POWER9LE_GLIBC)),)
LIB_NAMES_SUFFIX = 64-v2
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
LIB_NAMES_SUFFIX = 64
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC)),)
LIB_NAMES_SUFFIX = 64
endif


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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H3_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=4.14.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=4.14.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H5_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=4.14.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=4.14.52
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC))
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC))
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK33XX_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK339X_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A33XX_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK328X_GLIBC))
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.10.33
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.10.33
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S9XX_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A9XX_GLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.14.29
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC) $(TOOLCHAIN_POWER9_GLIBC)),)
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.2.0
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.2.0
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8LE_GLIBC) $(TOOLCHAIN_POWER9LE_GLIBC)),)
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.2.0
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.2.0
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.2.0
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.2.0
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_I686_GLIBC))
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
	@mkdir -p $(headers_dir)
	@cd $(headers_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET)             \
	  $(extra_configure_switches)
	@cd $(headers_dir) && $(MAKE) -j1 install-headers \
	                                  install-bootstrap-headers=yes $(env_sysroot)
	@cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_lib
	# ======= install 'lib-names-$(LIB_NAMES_SUFFIX).h' =======
	@mkdir -p $(sysroot_dir)/usr/include/gnu
	@install --mode=0644 $(headers_dir)/gnu/lib-names-$(LIB_NAMES_SUFFIX).h $(sysroot_dir)/usr/include/gnu
	@install --mode=0644 $(SRC_DIR)/include/gnu/stubs.h $(sysroot_dir)/usr/include/gnu
	# =========================================================
	@cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_install $(env_sysroot)
	@$(environment) $(CC) -nostdlib -nostartfiles -shared -x c /dev/null \
	                      -o $(sysroot_dir)/usr/lib$(LIBSUFFIX)/libc.so
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@

$(full_target): $(src_done)
	@mkdir -p $(full_dir)
	@echo "slibdir=/lib$(LIBSUFFIX)" >> $(full_dir)/configparms
	@cd $(full_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET)             \
	  $(extra_configure_switches)
	@cd $(full_dir) && $(environment) $(MAKE) all
	@cd $(full_dir) && $(environment) $(MAKE) -j1 install $(env_sysroot)
	@rm -f $(sysroot_dir)/usr/share/info/dir
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@
