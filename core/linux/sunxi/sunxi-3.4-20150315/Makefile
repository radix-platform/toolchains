

COMPONENT_TARGETS  = $(TOOLCHAIN_A2X_GLIBC)


include ../../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/Allwinner/sunxi-3.4

ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.0),)
REQUIRES  = core/gcc/5.3.0^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.1),)
REQUIRES  = core/gcc/5.3.0^static
endif

# ======= __END_OF_REQUIRES__ =======

tar_bz2_archive = $(SRC_PACKAGE_PATH)/Linux/Allwinner/sunxi-3.4/linux-sunxi-3.4-20150315.tar.bz2
SRC_ARCHIVE     = $(tar_bz2_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-sunxi-3.4-20150315
src_done        = $(TARGET_BUILD_DIR)/.source-done

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_EGLIBC) $(TOOLCHAIN_A2X_EGLIBC) \
                             $(TOOLCHAIN_A1X_GLIBC) $(TOOLCHAIN_A2X_GLIBC)),)
arch = arm
endif

BUILD_TARGETS = $(headers_target)


include ../../../../build-system/core.mk



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
