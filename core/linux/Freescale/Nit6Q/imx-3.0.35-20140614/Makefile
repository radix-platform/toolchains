

COMPONENT_TARGETS  = $(TOOLCHAIN_IMX6_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)


include ../../../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/Freescale/Nit6Q


ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.1),)
REQUIRES  = core/gcc/5.3.0^static
endif

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/Linux/Freescale/Nit6Q/linux-imx-3.0.35-20140614.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-imx-3.0.35-20140614
src_done        = $(TARGET_BUILD_DIR)/.source-done

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(findstring imx6, $(TOOLCHAIN)),)
arch = arm
endif


BUILD_TARGETS = $(headers_target)


include ../../../../../build-system/core.mk



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(SRC_DIR)/include/linux/version.h: $(src_done)
	@touch $(SRC_DIR)/.config
	@$(MAKE) -C $(SRC_DIR) include/linux/version.h

$(sysroot_dir)/usr/include/linux/autoconf.h: $(SRC_DIR)/include/linux/version.h
	@$(MAKE) -C $(SRC_DIR) headers_install ARCH=$(arch) INSTALL_HDR_PATH=$(sysroot_dir)/usr
	@touch $@

$(headers_target): $(sysroot_dir)/usr/include/linux/autoconf.h
	@( cd $(sysroot_dir)/usr/include ; \
	   for file in `find . -name *.install*` ; do \
	     rm -f $$file ; \
	   done ; \
	 )
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR)):headers" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
