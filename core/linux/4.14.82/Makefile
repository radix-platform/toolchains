
COMPONENT_TARGETS  = $(TOOLCHAIN_POWER8_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8LE_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9LE_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_R1000_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I686_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/v4.x

REQUIRES  = core/gcc/7.3.0^static

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/Linux/v4.x/linux-4.14.82.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-4.14.82
src_done        = $(TARGET_BUILD_DIR)/.source-done

PATCHES = PATCHES

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root


headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_POWER8_GLIBC) $(TOOLCHAIN_POWER9_GLIBC) \
                             $(TOOLCHAIN_POWER8LE_GLIBC) $(TOOLCHAIN_POWER9LE_GLIBC)),)
arch = powerpc
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_R1000_GLIBC)),)
arch = sparc
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC)  \
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
