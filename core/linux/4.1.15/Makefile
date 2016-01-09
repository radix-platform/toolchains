

COMPONENT_TARGETS  = $(TOOLCHAIN_I486_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_EGLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I486_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_P5600_GLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/Linux/v4.x

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.9),)
REQUIRES  = core/gcc/4.9.2^static
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.0),)
REQUIRES  = core/gcc/5.3.0^static
endif

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive  = $(SRC_PACKAGE_PATH)/Linux/v4.x/linux-4.1.15.tar.xz
SRC_ARCHIVE     = $(tar_xz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/linux-4.1.15
src_done        = $(TARGET_BUILD_DIR)/.source-done

sysroot_dir     = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root


headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC) \
                             $(TOOLCHAIN_I486_EGLIBC)   \
                             $(TOOLCHAIN_X86_64_GLIBC)  \
                             $(TOOLCHAIN_I486_GLIBC)),)
arch = x86
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC)),)
arch = mips
endif

BUILD_TARGETS = $(headers_target)


include ../../../build-system/core.mk



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
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
