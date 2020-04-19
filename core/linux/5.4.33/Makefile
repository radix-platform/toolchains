
COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_H3_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_H5_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6ULL_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_JZ47XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_P5600_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK328X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_S8XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_S9XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK33XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK339X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8LE_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9LE_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I686_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/v5.x

REQUIRES  = core/gcc/9.3.0^static

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/Linux/v5.x/linux-5.4.33.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-5.4.33
src_done        = $(TARGET_BUILD_DIR)/.source-done

PATCHES = PATCHES

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root


headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC) $(TOOLCHAIN_A2X_GLIBC) \
                             $(TOOLCHAIN_H3_GLIBC) $(TOOLCHAIN_IMX6_GLIBC) \
                             $(TOOLCHAIN_IMX6ULL_GLIBC) $(TOOLCHAIN_OMAP543X_GLIBC) \
                             $(TOOLCHAIN_RK328X_GLIBC) $(TOOLCHAIN_S8XX_GLIBC) \
                             $(TOOLCHAIN_A9XX_GLIBC) $(TOOLCHAIN_A33XX_GLIBC)),)
arch = arm
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_H5_GLIBC) $(TOOLCHAIN_S9XX_GLIBC) \
                             $(TOOLCHAIN_RK33XX_GLIBC) $(TOOLCHAIN_RK339X_GLIBC)),)
arch = arm64
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC) $(TOOLCHAIN_P5600_GLIBC)),)
arch = mips
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC) $(TOOLCHAIN_POWER9_GLIBC) \
                             $(TOOLCHAIN_POWER8LE_GLIBC) $(TOOLCHAIN_POWER9LE_GLIBC)),)
arch = powerpc
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC) \
                             $(TOOLCHAIN_I686_GLIBC)),)
arch = x86
endif


BUILD_TARGETS = $(headers_target)


include ../../../build-system/core.mk



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
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
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR)):headers" >> $(TOOLCHAIN_PATH)/README
	@touch $@
