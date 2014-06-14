

COMPONENT_TARGETS = $(TOOLCHAIN_IMX6_EGLIBC)
COMPONENT_TARGETS = $(TOOLCHAIN_OMAP543X_EGLIBC)


include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/U-Boot/denx

tar_bz2_archive  = $(SRC_PACKAGE_DIR)/U-Boot/denx/u-boot-2014.01.tar.bz2
src_dir          = u-boot-2014.01
build_dir        = $(TARGET_BUILD_DIR)/build

sysroot_dir   = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

src_done = $(SRC_DIR)/.source-done
SRC_DIR = $(TARGET_BUILD_DIR)/u-boot-2014.01
SRC_ARCHIVE = $(tar_bz2_archive)


  build_target = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed

environment    = HOSTCC=gcc CROSS_COMPILE=""


BUILD_TARGETS = $(install_target)

include ../../../build-system/core.mk


.PHONY: full


$(build_target): $(build_dir)
	@touch $@

$(install_target): full
	@touch $@

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_dir): $(src_done)
	mkdir -p $@
	$(MAKE) -C $(SRC_DIR) tools $(environment)
	@cp -a $(SRC_DIR)/tools/mkimage $@
	@cp -a $(SRC_DIR)/doc/mkimage.1 $@

full: $(build_target)
	@cp -a $(build_dir)/mkimage $(TOOLCHAIN_PATH)/bin
	@cp -a $(build_dir)/mkimage.1 $(TOOLCHAIN_PATH)/share/man/man1
