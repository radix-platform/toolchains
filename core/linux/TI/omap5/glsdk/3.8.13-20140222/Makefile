

COMPONENT_TARGETS  = $(TOOLCHAIN_OMAP543X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)


include ../../../../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/TI/omap5/glsdk

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.1),)
REQUIRES  = core/gcc/4.5.1^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.2 1.0.3 1.0.4),)
REQUIRES  = core/gcc/4.7.2^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.5),)
REQUIRES  = core/gcc/4.7.3^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.6),)
REQUIRES  = core/gcc/4.8.2^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.7 1.0.8),)
REQUIRES  = core/gcc/4.9.1^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.9),)
REQUIRES  = core/gcc/4.9.2^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.0),)
REQUIRES  = core/gcc/5.3.0^static
endif

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/Linux/TI/omap5/glsdk/linux-glsdk-3.8.13-20140222.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-glsdk-3.8.13-20140222
src_done        = $(TARGET_BUILD_DIR)/.source-done

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(findstring omap543x, $(TOOLCHAIN)),)
arch = arm
endif

BUILD_TARGETS = $(headers_target)


include ../../../../../../build-system/core.mk



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(SRC_DIR)/include/generated/uapi/linux/version.h: $(src_done)
	@touch $(SRC_DIR)/.config
	@$(MAKE) -C $(SRC_DIR) include/generated/uapi/linux/version.h

$(sysroot_dir)/usr/include/linux/autoconf.h: $(SRC_DIR)/include/generated/uapi/linux/version.h
	@$(MAKE) -C $(SRC_DIR) headers_install \
	            ARCH=$(arch) CROSS_COMPILE=$(TOOLCHAIN_PATH)/bin/$(TARGET)- \
	            INSTALL_HDR_PATH=$(sysroot_dir)/usr
	@touch $@

$(headers_target): $(sysroot_dir)/usr/include/linux/autoconf.h
	@( cd $(sysroot_dir)/usr/include ; \
	   for file in `find . -name *.install*` ; do \
	     rm -f $$file ; \
	   done ; \
	 )
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR)):headers" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
