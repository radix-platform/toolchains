

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_H3_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_H5_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_S8XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_S9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_RK33XX_NEWLIB)
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
COMPONENT_TARGETS += $(TOOLCHAIN_RK33XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8LE_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9LE_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_R1000_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I686_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


include ../../../build-system/config.mk

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
FLAVOURS = flat
endif

SOURCE_REQUIRES  = sources/GNU/binutils
SOURCE_REQUIRES += sources/uClinux/elf2flt

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive       = $(SRC_PACKAGE_PATH)/GNU/binutils/binutils-2.31.1.tar.xz
tar_bz2_archive_flat = $(SRC_PACKAGE_PATH)/uClinux/elf2flt/elf2flt-1.64.tar.bz2
SRC_ARCHIVE          = $(tar_xz_archive)
SRC_DIR              = $(TARGET_BUILD_DIR)/binutils-2.31.1
src_dir_name         = binutils-2.31.1
flat_src_dir_name    = elf2flt-1.64
src_done             = $(SRC_DIR)/.source-done
flat_src_done        = $(SRC_DIR)/.flat-source-done

PATCHES       = PATCHES

ifeq ($(FLAVOUR),flat)
OPT_PATCHES   = PATCHES.elf2flt
endif

build_dir            = $(TARGET_BUILD_DIR)/build
flat_build_dir       = $(TARGET_BUILD_DIR)/build-flat
install_dir          = $(TOOLCHAIN_PATH)

sysroot_dir          = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

build_target         = $(TARGET_BUILD_DIR)/.built
install_target       = $(TARGET_BUILD_DIR)/.installed

flat_build_target    = $(TARGET_BUILD_DIR)/.flat-built
flat_install_target  = $(TARGET_BUILD_DIR)/.flat-installed


ifeq ($(FLAVOUR),flat)
BUILD_TARGETS  = $(flat_build_target)
BUILD_TARGETS += $(flat_install_target)
else
BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)
endif

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=cortex-a7
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H3_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --disable-werror
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H5_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-multiarch
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --disable-werror
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A9XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --disable-werror
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S9XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-multiarch
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A33XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --disable-werror
extra_configure_switches += --enable-interwork
extra_configure_switches += --with-cpu=cortex-m0
extra_configure_switches += --with-arch=armv6-m
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK33XX_NEWLIB))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-multiarch
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(TOOLCHAIN_PATH)/$(TARGET)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=cortex-a7
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_H3_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a7
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_H5_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-fpu=neon-fp-armv8
extra_configure_switches += --with-abi=lp64
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S8XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=cortex-a5
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_S9XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-fpu=neon-fp-armv8
extra_configure_switches += --with-abi=lp64
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A9XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-fpu=neon-fp-armv8
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_RK33XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-fpu=neon-fp-armv8
extra_configure_switches += --with-abi=lp64
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A33XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --disable-multilib
extra_configure_switches += --with-cpu=cortex-a53
extra_configure_switches += --with-arch=armv8-a
extra_configure_switches += --with-fpu=neon-fp-armv8
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_RK328X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
# standard options:
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=cortex-a17
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_IMX6_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a9
extra_configure_switches += --with-fpu=vfpv3
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# standard options:
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a15
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-arch=mips32r2
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-arch=mips32r5
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-multilib
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
extra_configure_switches += --enable-targets=ppc64-radix-linux,powerpc64-radix-linux,ppc64-linux,powerpc64-linux,ppc-radix-linux,powerpc-radix-linux,ppc-linux,powerpc-linux
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER9_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-multilib
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
extra_configure_switches += --enable-targets=ppc64-radix-linux,powerpc64-radix-linux,ppc64-linux,powerpc64-linux,ppc-radix-linux,powerpc-radix-linux,ppc-linux,powerpc-linux
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8LE_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --disable-multilib
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
extra_configure_switches += --enable-targets=ppc64le-radix-linux,powerpc64le-radix-linux,ppc64le-linux,powerpc64le-linux,ppcle-radix-linux,powerpcle-radix-linux,ppcle-linux,powerpcle-linux
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER9LE_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --disable-multilib
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
extra_configure_switches += --enable-targets=ppc64le-radix-linux,powerpc64le-radix-linux,ppc64le-linux,powerpc64le-linux,ppcle-radix-linux,powerpcle-radix-linux,ppcle-linux,powerpcle-linux
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-multilib
extra_configure_switches += --enable-werror=no
extra_configure_switches += --enable-plugins
extra_configure_switches += --enable-targets=sparc64-radix-linux,sparc64-linux,sparc-radix-linux,sparc-linux
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# The --enable-initfini-array option was added in binutils-2.21.51.0.3.
# This option currently causes a world of hurt trying to compile glibc,
# and might break static libraries or cause other ill effects.  There
# is an upstream patch for glibc but it does not avoid all of the known
# problems (and there may be some unknown ones, too), so we will avoid
# introducing this feature for now.
# References:
# http://sourceware.org/bugzilla/show_bug.cgi?id=12343
# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=46770
extra_configure_switches += --disable-initfini-array
# standard options:
extra_configure_switches += --enable-targets=x86_64-radix-linux
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_I686_GLIBC)),)
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=https://radix.pro'
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches += --enable-gold=yes
extra_configure_switches += --enable-ld=default
extra_configure_switches += --enable-werror=no
# The --enable-initfini-array option was added in binutils-2.21.51.0.3.
# This option currently causes a world of hurt trying to compile glibc,
# and might break static libraries or cause other ill effects.  There
# is an upstream patch for glibc but it does not avoid all of the known
# problems (and there may be some unknown ones, too), so we will avoid
# introducing this feature for now.
# References:
# http://sourceware.org/bugzilla/show_bug.cgi?id=12343
# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=46770
extra_configure_switches += --disable-initfini-array
# standard options:
extra_configure_switches += --enable-targets=i686-radix-linux
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC)),)
	# ======= On ppc64 and aarch64, we might use 64KiB pages =======
	@( cd $(SRC_DIR) ; \
	   sed -i -e '/#define.*ELF_COMMONPAGESIZE/s/0x1000$/0x10000/' bfd/elf*ppc.c ; \
	   sed -i -e '/common_pagesize/s/4 /64 /' gold/powerpc.cc ; \
	 )
endif
	@touch $@

$(flat_src_done): $(src_done)
	@echo "Expanding $(tar_bz2_archive_flat)"
	@tar xjf $(tar_bz2_archive_flat) -C $(TARGET_BUILD_DIR)
	$(APPLY_OPT_PATCHES)
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)             \
	  --target=$(TARGET)                     \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  --disable-nls                          \
	  $(extra_configure_switches)
	@$(MAKE) -C $(build_dir)
	@$(MAKE) -C $(build_dir) info
	@touch $@

$(install_target): $(build_target)
	@mkdir -p $(install_dir)
	@$(MAKE) -j1 -C $(build_dir) install
	@$(MAKE) -j1 -C $(build_dir) install-info
	@rm -f $(TOOLCHAIN_PATH)/share/info/dir
	@echo ""                                       > $(TOOLCHAIN_PATH)/README
	@echo "  TOOLCHAIN = $(TOOLCHAIN)"            >> $(TOOLCHAIN_PATH)/README
	@echo "     TARGET = $(TARGET)"               >> $(TOOLCHAIN_PATH)/README
	@echo "  BASE_PATH = $(TOOLCHAINS_BASE_PATH)" >> $(TOOLCHAIN_PATH)/README
	@echo "  DIRECTORY = $(TOOLCHAIN_DIR)"        >> $(TOOLCHAIN_PATH)/README
	@echo "    VERSION = $(TOOLCHAIN_VERSION)"    >> $(TOOLCHAIN_PATH)/README
	@echo ""                                      >> $(TOOLCHAIN_PATH)/README
	@echo "-----------"                           >> $(TOOLCHAIN_PATH)/README
	@echo ""                                      >> $(TOOLCHAIN_PATH)/README
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@

$(flat_build_target): $(flat_src_done) $(build_target)
	@mkdir -p $(flat_build_dir)
	@cd $(flat_build_dir) && LIBS=-ldl ../$(flat_src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)                              \
	  --target=$(TARGET)                                      \
	  --with-binutils-include-dir=../$(src_dir_name)/include/ \
	  --with-bfd-include-dir=../build/bfd/                    \
	  --with-libbfd=../build/bfd/libbfd.a                     \
	  --with-libiberty=../build/libiberty/libiberty.a         \
	  --disable-got-check
	@$(MAKE) -C $(flat_build_dir)
	@touch $@

$(flat_install_target): $(flat_build_target) $(install_target)
	@$(MAKE) -j1 -C $(flat_build_dir) install
	@touch $@
