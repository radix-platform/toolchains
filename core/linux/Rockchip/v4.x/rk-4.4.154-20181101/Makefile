

COMPONENT_TARGETS  = $(TOOLCHAIN_RK328X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK33XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK339X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_GLIBC)


include ../../../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/Rockchip/v4.x


REQUIRES  = core/gcc/9.2.0^static

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/Linux/Rockchip/v4.x/linux-rk-4.4.154-20181101.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-rk-4.4.154-20181101
src_done        = $(TARGET_BUILD_DIR)/.source-done

PATCHES = PATCHES

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed


ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_RK33XX_GLIBC) \
                             $(TOOLCHAIN_RK339X_GLIBC)),)
arch = arm64
endif
ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A33XX_GLIBC)  \
                             $(TOOLCHAIN_RK328X_GLIBC)),)
arch = arm
endif


BUILD_TARGETS = $(headers_target)


include ../../../../../build-system/core.mk



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(SRC_DIR)/include/generated/uapi/linux/version.h: $(src_done)
	@touch $(SRC_DIR)/.config
	@$(MAKE) -C $(SRC_DIR) \
	  ARCH=$(arch) CROSS_COMPILE=$(TOOLCHAIN_PATH)/bin/$(TARGET)- \
	  include/generated/uapi/linux/version.h

$(sysroot_dir)/usr/include/linux/autoconf.h: $(SRC_DIR)/include/generated/uapi/linux/version.h
	@$(MAKE) -j1 -C $(SRC_DIR) headers_install                    \
	  ARCH=$(arch) CROSS_COMPILE=$(TOOLCHAIN_PATH)/bin/$(TARGET)- \
	  INSTALL_HDR_PATH=$(sysroot_dir)/usr
	@touch $@

$(headers_target): $(sysroot_dir)/usr/include/linux/autoconf.h
	@( cd $(sysroot_dir)/usr/include ; \
	   for file in `find . -name *.install*` ; do \
	     rm -f $$file ; \
	   done ; \
	 )
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR)):headers" >> $(TOOLCHAIN_PATH)/README
	@touch $@
