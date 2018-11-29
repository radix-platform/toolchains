

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_H3_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_H5_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_S8XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_S9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_AT91SAM7S_NEWLIB)

COMPONENT_TARGETS += $(TOOLCHAIN_LPC17XX_UCLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_A1X_GLIBC)
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

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8LE_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9LE_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_R1000_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I686_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


FLAVOURS = static second full


include ../../../build-system/config.mk


SOURCE_REQUIRES  = sources/GNU/gcc/gcc-6.5.0
SOURCE_REQUIRES += sources/GNU/gmp
SOURCE_REQUIRES += sources/GNU/mpfr
SOURCE_REQUIRES += sources/GNU/mpc
SOURCE_REQUIRES += sources/inria/isl


ifneq ($(findstring newlib, $(TOOLCHAIN)),)
ifeq ($(FLAVOUR),static)
REQUIRES  = core/newlib/2.5.0-20170623^headers
endif
ifeq ($(FLAVOUR),full)
REQUIRES  = core/newlib/2.5.0-20170623^full
endif
endif

ifneq ($(findstring uclibc, $(TOOLCHAIN)),)
ifeq ($(FLAVOUR),static)
REQUIRES  = core/binutils/2.31.1^flat
endif
ifeq ($(FLAVOUR),second)
REQUIRES  = core/uclibc/0.9.33.2^headers
endif
ifeq ($(FLAVOUR),full)
REQUIRES  = core/uclibc/0.9.33.2^full
endif
endif

ifneq ($(findstring -glibc, $(TOOLCHAIN)),)
ifeq ($(FLAVOUR),static)
REQUIRES  = core/binutils/2.31.1
endif
ifeq ($(FLAVOUR),second)
REQUIRES  = core/glibc/2.28^headers
endif
ifeq ($(FLAVOUR),full)
REQUIRES  = core/glibc/2.28^full
endif
endif

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive        = $(SRC_PACKAGE_PATH)/GNU/gcc/gcc-6.5.0/gcc-6.5.0.tar.xz
tar_xz_archive_gmp    = $(SRC_PACKAGE_PATH)/GNU/gmp/gmp-6.1.2.tar.xz
tar_xz_archive_mpfr   = $(SRC_PACKAGE_PATH)/GNU/mpfr/mpfr-4.0.1.tar.xz
tar_gz_archive_mpc    = $(SRC_PACKAGE_PATH)/GNU/mpc/mpc-1.1.0.tar.gz
tar_xz_archive_isl    = $(SRC_PACKAGE_PATH)/inria/isl/isl-0.20.tar.xz
SRC_ARCHIVE           = $(tar_xz_archive)
SRC_DIR               = $(TARGET_BUILD_DIR)/gcc-6.5.0
src_dir_name          = gcc-6.5.0
src_done              = $(TARGET_BUILD_DIR)/.source-done
gmp_src_done          = $(TARGET_BUILD_DIR)/.gmp-source-done
mpfr_src_done         = $(TARGET_BUILD_DIR)/.mpfr-source-done
mpc_src_done          = $(TARGET_BUILD_DIR)/.mpc-source-done
isl_src_done          = $(TARGET_BUILD_DIR)/.isl-source-done

ifneq ($(TOOLCHAIN),)
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB)),)
PATCHES = PATCHES.at91sam7s
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_NEWLIB)),)
PATCHES = PATCHES.a1x
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A2X_NEWLIB)),)
PATCHES = PATCHES.a2x
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_H3_NEWLIB)),)
PATCHES = PATCHES.h3
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_H5_GLIBC)),)
PATCHES = PATCHES.aarch64
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A9XX_NEWLIB)),)
PATCHES = PATCHES.a9xx
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A33XX_NEWLIB)),)
PATCHES = PATCHES.a33xx
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB)),)
PATCHES = PATCHES.s8xx
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC)),)
PATCHES = PATCHES.lpc17xx
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC)),)
PATCHES = PATCHES.jz47xx
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC)),)
PATCHES = PATCHES.p5600
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC) $(TOOLCHAIN_POWER9_GLIBC)),)
PATCHES = PATCHES.powerpc
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8LE_GLIBC) $(TOOLCHAIN_POWER9LE_GLIBC)),)
PATCHES = PATCHES.powerpcle
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
PATCHES = PATCHES.sparc
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_I686_GLIBC)),)
PATCHES = PATCHES.i386
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S9XX_GLIBC)),)
PATCHES = PATCHES.aarch64
else
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC)),)
PATCHES = PATCHES.x86_64
else
PATCHES = PATCHES
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif
endif

build_dir             = $(TARGET_BUILD_DIR)/build

sysroot_dir           = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

static_build_target   = $(TARGET_BUILD_DIR)/.static-built
static_install_target = $(TARGET_BUILD_DIR)/.static-installed
second_build_target   = $(TARGET_BUILD_DIR)/.second-built
second_install_target = $(TARGET_BUILD_DIR)/.second-installed
full_build_target     = $(TARGET_BUILD_DIR)/.full-built
full_install_target   = $(TARGET_BUILD_DIR)/.full-installed

#
# Cross GNAT requires native GNAT on the build machine with same version.
# To be independed from distribution we are working the build GNAT tools
# created and installed with prefix $(GNATTOOLS_DEST_DIR)
#
# see: build-system/3pp/gnattools/4.9.2 for more information.
#
GNATTOOLS_DEST_DIR = $(BUILDSYSTEM)/gnattools/6.5.0/usr

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(GNATTOOLS_DEST_DIR)/bin:$(PATH)
environment += GNATBIND=$(GNATTOOLS_DEST_DIR)/bin/gnatbind
environment += GNATMAKE=$(GNATTOOLS_DEST_DIR)/bin/gnatmake


LIBSUFFIX    =


ifeq ($(FLAVOUR),static)
BUILD_TARGETS  = $(static_build_target)
BUILD_TARGETS += $(static_install_target)
endif

ifeq ($(FLAVOUR),second)
BUILD_TARGETS  = $(second_build_target)
BUILD_TARGETS += $(second_install_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS  = $(full_build_target)
BUILD_TARGETS += $(full_install_target)
endif


include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a8
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs
extra_configure_switches += --with-dwarf2
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --with-newlib
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-tune=cortex-a7
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs
extra_configure_switches += --with-dwarf2
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --with-newlib
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H3_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-threads
extra_configure_switches += --disable-tls
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --without-headers
extra_configure_switches += --enable-languages=c
else
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-headers=yes
extra_configure_switches += --enable-languages=c,c++
endif
extra_configure_switches += --with-newlib
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
extra_configure_switches += --with-extra-multilibs=armv7-a
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H5_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-multiarch
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --disable-__cxa_atexit
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-threads
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --without-headers
extra_configure_switches += --enable-languages=c
else
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-headers=yes
extra_configure_switches += --enable-languages=c,c++
endif
extra_configure_switches += --with-newlib
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-threads
extra_configure_switches += --disable-tls
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --without-headers
extra_configure_switches += --enable-languages=c
else
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-headers=yes
extra_configure_switches += --enable-languages=c,c++
endif
extra_configure_switches += --with-newlib
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
extra_configure_switches += --with-extra-multilibs=armv7-a
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A9XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-threads
extra_configure_switches += --disable-tls
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --without-headers
extra_configure_switches += --enable-languages=c
else
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-headers=yes
extra_configure_switches += --enable-languages=c,c++
endif
extra_configure_switches += --with-newlib
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
extra_configure_switches += --with-extra-multilibs=armv7-m
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A33XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-decimal-float
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-threads
extra_configure_switches += --disable-tls
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --without-headers
extra_configure_switches += --enable-languages=c
else
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-headers=yes
extra_configure_switches += --enable-languages=c,c++
endif
extra_configure_switches += --with-newlib
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
extra_configure_switches += --with-extra-multilibs=armv6-m
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S9XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-multiarch
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --disable-__cxa_atexit
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-threads
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --without-headers
extra_configure_switches += --enable-languages=c
else
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-headers=yes
extra_configure_switches += --enable-languages=c,c++
endif
extra_configure_switches += --with-newlib
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --enable-fpu=no
extra_configure_switches += --enable-nofmult=no
extra_configure_switches += --enable-26bit=no
extra_configure_switches += --enable-underscore=no
extra_configure_switches += --with-float=soft
extra_configure_switches += --with-dwarf2
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --with-newlib
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --without-headers
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a8
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs-linux
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-tune=cortex-a7
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_H3_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a7
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --with-mode=thumb
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# --without-headers replacement for --with-newlib, to make libgcc independed from glibc:
extra_configure_switches += --without-headers
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
# add
extra_configure_switches += --enable-threads=posix
extra_configure_switches += --enable-linker-build-id
extra_configure_switches += --enable-gnu-unique-object
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_H5_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --disable-multilib
extra_configure_switches += --enable-multiarch
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-abi=lp64
extra_configure_switches += --enable-fix-cortex-a53-835769
extra_configure_switches += --enable-fix-cortex-a53-843419
# add
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S8XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a5
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs-linux
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S9XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --disable-multilib
extra_configure_switches += --enable-multiarch
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-abi=lp64
extra_configure_switches += --enable-fix-cortex-a53-835769
extra_configure_switches += --enable-fix-cortex-a53-843419
# add
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A9XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --disable-multilib
extra_configure_switches += --enable-multiarch
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-fpu=neon-fp-armv8
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_RK328X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-tune=cortex-a17
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_IMX6_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a9
extra_configure_switches += --with-fpu=vfpv3
extra_configure_switches += --with-abi=aapcs-linux
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --with-mode=thumb
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# --without-headers replacement for --with-newlib, to make libgcc independed from glibc:
extra_configure_switches += --without-headers
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
# add
extra_configure_switches += --enable-threads=posix
extra_configure_switches += --enable-linker-build-id
extra_configure_switches += --enable-gnu-unique-object
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a15
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
# add
extra_configure_switches += --with-float=hard
extra_configure_switches += --with-mode=thumb
extra_configure_switches += --enable-gold
extra_configure_switches += --enable-c99
extra_configure_switches += --enable-long-long
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# --without-headers replacement for --with-newlib, to make libgcc independed from glibc:
extra_configure_switches += --without-headers
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
# add
extra_configure_switches += --enable-threads=posix
extra_configure_switches += --enable-linker-build-id
extra_configure_switches += --enable-gnu-unique-object
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch-32=mips32r2
extra_configure_switches += --with-arch-64=mips64r2
extra_configure_switches += --with-float=hard
extra_configure_switches += --with-mips-plt
extra_configure_switches += --enable-target-optspace
extra_configure_switches += --enable-symvers=gnu
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-threads
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=mips32r5
extra_configure_switches += --with-tune=p5600
extra_configure_switches += --with-float=hard
extra_configure_switches += --with-mips-plt
extra_configure_switches += --enable-target-optspace
extra_configure_switches += --enable-symvers=gnu
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-long-long
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-threads
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-multilib-list=m64,m32
extra_configure_switches += --with-cpu-32=power8
extra_configure_switches += --with-tune-32=power8
extra_configure_switches += --with-cpu-64=power8
extra_configure_switches += --with-tune-64=power8
extra_configure_switches += --with-long-double-128
# gnu-indirect-function available for i[3456]86*|x86_64*|ppc*|ppc64*|s390*|arm*|aarch64*|mips* targets:
extra_configure_switches += --enable-gnu-indirect-function
extra_configure_switches += --enable-secureplt
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER9_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-multilib-list=m64,m32
extra_configure_switches += --with-cpu-32=power9
extra_configure_switches += --with-tune-32=power9
extra_configure_switches += --with-cpu-64=power9
extra_configure_switches += --with-tune-64=power9
extra_configure_switches += --with-long-double-128
# gnu-indirect-function available for i[3456]86*|x86_64*|ppc*|ppc64*|s390*|arm*|aarch64*|mips* targets:
extra_configure_switches += --enable-gnu-indirect-function
extra_configure_switches += --enable-secureplt
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8LE_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=power8
extra_configure_switches += --with-tune=power8
extra_configure_switches += --with-long-double-128
# gnu-indirect-function available for i[3456]86*|x86_64*|ppc*|ppc64*|s390*|arm*|aarch64*|mips* targets:
extra_configure_switches += --enable-gnu-indirect-function
extra_configure_switches += --enable-secureplt
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER9LE_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=power9
extra_configure_switches += --with-tune=power9
extra_configure_switches += --with-long-double-128
# gnu-indirect-function available for i[3456]86*|x86_64*|ppc*|ppc64*|s390*|arm*|aarch64*|mips* targets:
extra_configure_switches += --enable-gnu-indirect-function
extra_configure_switches += --enable-secureplt
extra_configure_switches += --disable-isl-version-check
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=ultrasparc3
extra_configure_switches += --with-tune=ultrasparc3
extra_configure_switches += --with-long-double-128
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-linux-futex
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_I686_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=i686
extra_configure_switches += --with-tune=i686
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libmpx
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-multilib-list=m64,m32
extra_configure_switches += --disable-isl-version-check
extra_configure_switches += --disable-libmpx
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libatomic
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libitm
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-libsanitizer
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libstdc++-v3
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++,objc,obj-c++,java,fortran,go,lto,ada
extra_configure_switches += --enable-libstdcxx-dual-abi
extra_configure_switches += --with-default-libstdcxx-abi=new
extra_configure_switches += --disable-libstdcxx-pch
extra_configure_switches += --disable-libunwind-exceptions
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(gmp_src_done): $(src_done)
	@echo "Expanding $(tar_xz_archive_gmp)"
	@tar xJf $(tar_xz_archive_gmp) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../gmp-6.1.2 gmp
	@touch $@

$(mpfr_src_done): $(src_done)
	@echo "Expanding $(tar_xz_archive_mpfr)"
	@tar xJf $(tar_xz_archive_mpfr) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpfr-4.0.1 mpfr
	@touch $@

$(mpc_src_done): $(src_done)
	@echo "Expanding $(tar_gz_archive_mpc)"
	@tar xzf $(tar_gz_archive_mpc) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpc-1.1.0 mpc
	@touch $@

$(isl_src_done): $(src_done)
	@echo "Expanding $(tar_xz_archive_isl)"
	@tar xJf $(tar_xz_archive_isl) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../isl-0.20 isl
	@touch $@

$(static_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done) $(isl_src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_dir) all
	@touch $@

$(static_install_target): $(static_build_target)
	@$(MAKE) $(environment) -j1 -C $(build_dir) install
	@rm -f $(TOOLCHAIN_PATH)/share/info/dir
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@

$(second_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done) $(isl_src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_dir) all
	@touch $@

$(second_install_target): $(second_build_target)
	@$(MAKE) $(environment) -j1 -C $(build_dir) install
	@rm -f $(TOOLCHAIN_PATH)/share/info/dir
ifneq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
	@cp -d $(TOOLCHAIN_PATH)/$(TARGET)/lib/libgcc_s.so $(sysroot_dir)/usr/lib
	@cp    $(TOOLCHAIN_PATH)/$(TARGET)/lib/libgcc_s.so.1 $(sysroot_dir)/usr/lib
endif
ifneq ($(findstring x86_64, $(TOOLCHAIN)),)
	@cp -d $(TOOLCHAIN_PATH)/$(TARGET)/lib32/libgcc_s.so $(sysroot_dir)/usr/lib32
	@cp    $(TOOLCHAIN_PATH)/$(TARGET)/lib32/libgcc_s.so.1 $(sysroot_dir)/usr/lib32
endif
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@

$(full_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done) $(isl_src_done)
	@mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	$(environment) $(MAKE) -C $(build_dir) all
	@touch $@

#
# Before installing final GCC we remove libgcc builded with second GCC.
# The final gcc doesn't install libgcc_s.so, libstdc++.so into $(sysroot_dir)/usr/{lib|lib32}
# and it is not needed.
# NOTE: if you want to install libgcc_s.so, libstdc++.so and other libraries builded with GCC
#       and placed into $(TOOLCHAIN_PATH)/{lib|lib32} during GCC installation into TARGET
#       root file system then you should change *.la files. So the lines
#
# libdir='/opt/toolchain/x86_64-PC-linux-glibc/1.0.0/x86_64-radix-linux-gnu/lib/../lib32'
#
# where '/opt/toolchain/x86_64-PC-linux-glibc/1.0.0/x86_64-radix-linux-gnu' is the same
#    as '$(TOOLCHAIN_PATH)/$(TARGET)'
# should be replaced by
# libdir='/usr/lib/../lib32'
#
# In the other words we hould do following
#
#	@cat $(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX)/*.la | \
#	  $(SED) -e "s|$(TOOLCHAIN_PATH)/$(TARGET)|/usr/lib$(LIBSUFFIX)|g" > \
#	  $(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX)/*.la.tmp && \
#	  mv $(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX)/*.la.tmp \
#	     $(target_rootfs)/usr/lib$(LIBSUFFIX)/*.la
#
# for each *.la file in the $(TOOLCHAIN_PATH)/$(TARGET)/{lib|lib32} directory.
#

$(full_install_target): $(full_build_target)
	@rm -f $(sysroot_dir)/usr/lib/libgcc_s.so
	@rm -f $(sysroot_dir)/usr/lib/libgcc_s.so.1
ifneq ($(findstring x86_64, $(TOOLCHAIN)),)
	@rm -f $(sysroot_dir)/usr/lib32/libgcc_s.so
	@rm -f $(sysroot_dir)/usr/lib32/libgcc_s.so.1
endif
	@$(MAKE) $(environment) -j1 -C $(build_dir) install
	@rm -f $(TOOLCHAIN_PATH)/share/info/dir
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@
