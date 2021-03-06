

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_EGLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_JZ47XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_P5600_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK328X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_S805_GLIBC)


include ../../../../build-system/config.mk


SOURCE_REQUIRES = sources/U-Boot/denx

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.4),)
REQUIRES  = core/gcc/4.7.2^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.5),)
REQUIRES  = core/gcc/4.7.3^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.6),)
REQUIRES  = core/gcc/4.8.2^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.7 1.0.8),)
REQUIRES  = core/gcc/4.9.1^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.9),)
REQUIRES  = core/gcc/4.9.2^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.0),)
REQUIRES  = core/gcc/5.3.0^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.1),)
REQUIRES  = core/gcc/5.3.0^full
endif

# ======= __END_OF_REQUIRES__ =======

tar_bz2_archive  = $(SRC_PACKAGE_PATH)/U-Boot/denx/u-boot-2014.01.tar.bz2
SRC_ARCHIVE      = $(tar_bz2_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/u-boot-2014.01
src_dir_name     = u-boot-2014.01
src_done         = $(TARGET_BUILD_DIR)/.source-done


build_dir        = $(TARGET_BUILD_DIR)/build

sysroot_dir      = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

build_target     = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed

environment      = HOSTCC="$(CCACHE)/usr/bin/gcc" CROSS_COMPILE=""


BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)


include ../../../../build-system/core.mk


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	mkdir -p $(build_dir)
	$(MAKE) -C $(SRC_DIR) tools $(environment)
	@cp -a $(SRC_DIR)/tools/mkimage $(build_dir)
	@cp -a $(SRC_DIR)/doc/mkimage.1 $(build_dir)
	@touch $@

$(install_target): $(build_target)
	@cp -a $(build_dir)/mkimage $(TOOLCHAIN_PATH)/bin/$(TARGET)-mkimage
	@cp -a $(build_dir)/mkimage.1 $(TOOLCHAIN_PATH)/share/man/man1
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
