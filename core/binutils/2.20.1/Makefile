

COMPONENT_TARGETS  = $(TOOLCHAIN_AT91SAM7S_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_EGLIBC)


include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/GNU/binutils

tar_bz2_archive = $(SRC_PACKAGE_DIR)/GNU/binutils/binutils-2.20.1a.tar.bz2
SRC_ARCHIVE     = $(tar_bz2_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/binutils-2.20.1
src_dir_name    = binutils-2.20.1
src_done        = $(SRC_DIR)/.source-done

ifneq ($(TOOLCHAIN),)
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_EGLIBC))
PATCHES = PATCHES.mips32
else
PATCHES = PATCHES
endif
endif

build_dir       = $(TARGET_BUILD_DIR)/build
install_dir     = $(TOOLCHAIN_PATH)

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

build_target    = $(TARGET_BUILD_DIR)/.built
install_target  = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS = $(install_target)

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-werror
extra_configure_switches += --with-float=soft
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-werror
extra_configure_switches += --with-float=soft
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_EGLIBC))
extra_configure_switches  = --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --disable-werror
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_EGLIBC))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-werror
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
extra_configure_switches  = --enable-targets=x86_64-kxLab-linux,x86_64-radix-linux,x86_64-kxLab-linux-gnulibc1,x86_64-kxLab-linux-gnuaout
extra_configure_switches += --enable-64-bit-bfd
extra_configure_switches += --disable-werror
extra_configure_switches += --with-sysroot=$(sysroot_dir)
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(build_target): $(src_done)
	mkdir -p $(build_dir)
	cd $(build_dir) && ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)                    \
	  --target=$(TARGET)                            \
	  --infodir=$(TOOLCHAIN_PATH)/share/info        \
	  --mandir=$(TOOLCHAIN_PATH)/share/man          \
	  --disable-nls                                 \
	  $(extra_configure_switches)
	$(MAKE) -C $(build_dir)
	$(MAKE) -C $(build_dir) info
	@touch $@

$(install_target): $(build_target)
	mkdir -p $(install_dir)
	$(MAKE) -C $(build_dir) install
	$(MAKE) -C $(build_dir) install-info
	@touch $@
