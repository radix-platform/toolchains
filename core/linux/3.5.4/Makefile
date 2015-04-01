

COMPONENT_TARGETS  = $(TOOLCHAIN_X86_64_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/Linux/v3.x

tar_bz2_archive = $(SRC_PACKAGE_DIR)/Linux/v3.x/linux-3.5.4.tar.bz2
SRC_ARCHIVE     = $(tar_bz2_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-3.5.4
src_done        = $(TARGET_BUILD_DIR)/.source-done

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC) $(TOOLCHAIN_X86_64_GLIBC)),)
arch = x86
endif

BUILD_TARGETS = $(headers_target)


include ../../../build-system/core.mk



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(SRC_DIR)/include/linux/version.h: $(src_done)
	@touch $(SRC_DIR)/.config
	$(MAKE) -C $(SRC_DIR) include/linux/version.h

$(sysroot_dir)/usr/include/linux/autoconf.h: $(SRC_DIR)/include/linux/version.h
	$(MAKE) -C $(SRC_DIR) headers_install \
	           ARCH=$(arch) CROSS_COMPILE=$(TOOLCHAIN_PATH)/bin/$(TARGET)- \
	           INSTALL_HDR_PATH=$(sysroot_dir)/usr
	@touch $@

$(headers_target): $(sysroot_dir)/usr/include/linux/autoconf.h
	@( cd $(sysroot_dir)/usr/include ; \
	   for file in `find . -name *.install*` ; do \
	     rm -f $$file ; \
	   done ; \
	 )
	@touch $@
