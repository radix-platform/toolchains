

COMPONENT_TARGETS  = $(TOOLCHAIN_S9XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_GLIBC)


include ../../../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/Amlogic/P201


REQUIRES  = core/gcc/9.2.0^static

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/Linux/Amlogic/P201/linux-aml-3.14.29-20160818.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-aml-3.14.29-20160818
src_done        = $(TARGET_BUILD_DIR)/.source-done

PATCHES = PATCHES

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed


ifneq ($(findstring s9xx, $(TOOLCHAIN)),)
arch = arm64
endif
ifneq ($(findstring a9xx, $(TOOLCHAIN)),)
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
