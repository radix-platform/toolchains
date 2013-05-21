

COMPONENT_TARGETS = $(TOOLCHAIN_A1X_EGLIBC)

include ../../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/Linux/sunxi

tar_bz2_archive = $(SRC_PACKAGE_DIR)/Linux/sunxi/linux-3.0.52-r2.tar.bz2

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

src_done = $(TARGET_BUILD_DIR)/.source-done
SRC_DIR  = $(TARGET_BUILD_DIR)/linux-3.0.52-r2
SRC_ARCHIVE = $(tar_bz2_archive)

headers_target = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(findstring a1x, $(TOOLCHAIN)),)
arch = arm
endif

BUILD_TARGETS = $(headers_target)

include ../../../../build-system/core.mk


.PHONY: headers


$(headers_target): headers
	@touch $@

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(SRC_DIR)/include/linux/version.h: $(src_done)
	touch $(SRC_DIR)/.config
	$(MAKE) -C $(SRC_DIR) include/linux/version.h

$(sysroot_dir)/usr/include/linux/autoconf.h: $(SRC_DIR)/include/linux/version.h
	$(MAKE) -C $(SRC_DIR) headers_install ARCH=$(arch) INSTALL_HDR_PATH=$(sysroot_dir)/usr
	touch $@

headers: $(sysroot_dir)/usr/include/linux/autoconf.h
	@cd $(sysroot_dir)/usr/include ; \
	for file in `find . -name *.install*` ; do \
	  rm -f $$file; \
	done
