

COMPONENT_TARGETS  = $(TOOLCHAIN_DM644X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_GLIBC)


include ../../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/dm644x

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

ifneq ($(findstring dm644x, $(TOOLCHAIN)),)
tar_bz2_archive = $(SRC_PACKAGE_PATH)/Linux/dm644x/linux-2.6.36.tar.bz2
else
tar_bz2_archive = $(SRC_PACKAGE_PATH)/Linux/v2.6/linux-2.6.36.tar.bz2
endif

SRC_ARCHIVE     = $(tar_bz2_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-2.6.36
src_done        = $(TARGET_BUILD_DIR)/.source-done

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(findstring dm644x, $(TOOLCHAIN)),)
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
