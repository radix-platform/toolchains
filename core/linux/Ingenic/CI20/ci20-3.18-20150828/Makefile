

COMPONENT_TARGETS  = $(TOOLCHAIN_JZ47XX_GLIBC)


include ../../../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/Ingenic/CI20


ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.9),)
REQUIRES  = core/gcc/4.9.2^static
endif

# ======= __END_OF_REQUIRES__ =======

tar_bz2_archive = $(SRC_PACKAGE_PATH)/Linux/Ingenic/CI20/linux-ci20-3.18-20150828.tar.bz2
SRC_ARCHIVE     = $(tar_bz2_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-ci20-3.18-20150828
src_done        = $(TARGET_BUILD_DIR)/.source-done

defconfig       = $(CURDIR)/config/ci20-3.18.defconfig

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC)),)
arch = mips
endif

BUILD_TARGETS = $(headers_target)


include ../../../../../build-system/core.mk



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(SRC_DIR)/include/generated/uapi/linux/version.h: $(src_done)
	@cp $(defconfig) $(SRC_DIR)/.config
	@$(MAKE) -C $(SRC_DIR) \
	  ARCH=$(arch) CROSS_COMPILE=$(TOOLCHAIN_PATH)/bin/$(TARGET)- \
	  include/generated/uapi/linux/version.h

$(sysroot_dir)/usr/include/linux/autoconf.h: $(SRC_DIR)/include/generated/uapi/linux/version.h
	@$(MAKE) -C $(SRC_DIR) headers_install                        \
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
