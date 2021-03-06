

COMPONENT_TARGETS  = $(TOOLCHAIN_AT91SAM7S_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_NEWLIB)

COMPONENT_TARGETS += $(TOOLCHAIN_LPC17XX_UCLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_EGLIBC)


include ../../../build-system/config.mk

SOURCE_REQUIRES = sources/GNU/binutils

# ======= __END_OF_REQUIRES__ =======

tar_bz2_archive = $(SRC_PACKAGE_PATH)/GNU/binutils/binutils-2.22.tar.bz2
SRC_ARCHIVE     = $(tar_bz2_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/binutils-2.22
src_dir_name    = binutils-2.22
src_done        = $(SRC_DIR)/.source-done

PATCHES         = PATCHES

build_dir       = $(TARGET_BUILD_DIR)/build
install_dir     = $(TOOLCHAIN_PATH)

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

build_target    = $(TARGET_BUILD_DIR)/.built
install_target  = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches  = '--with-bugurl=http://www.radix.pro'
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_EGLIBC))
extra_configure_switches  = --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_EGLIBC))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
extra_configure_switches += --with-cpu=arm926ej-s
extra_configure_switches += --with-arch=armv5tej
extra_configure_switches += --with-tune=arm926ej-s
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_EGLIBC))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-arch=mips32
extra_configure_switches += --disable-werror
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
# experimental gold linker( DEFAULT_LD=ld.bfd ):
extra_configure_switches  = --enable-gold=yes
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
extra_configure_switches += --enable-targets=x86_64-kxLab-linux,x86_64-radix-linux,x86_64-kxLab-linux-gnulibc1,x86_64-kxLab-linux-gnuaout
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)                    \
	  --target=$(TARGET)                            \
	  --infodir=$(TOOLCHAIN_PATH)/share/info        \
	  --mandir=$(TOOLCHAIN_PATH)/share/man          \
	  --disable-nls                                 \
	  $(extra_configure_switches)
	@$(MAKE) -C $(build_dir)
	@$(MAKE) -C $(build_dir) info
	@touch $@

$(install_target): $(build_target)
	@mkdir -p $(install_dir)
	@$(MAKE) -C $(build_dir) install
	@$(MAKE) -C $(build_dir) install-info
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
