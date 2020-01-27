

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)


include ../../../../build-system/config.mk

SOURCE_REQUIRES = sources/tools/allwinner/sunxi-tools

REQUIRES  = core/gcc/9.2.0^full

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive   = $(SRC_PACKAGE_PATH)/tools/allwinner/sunxi-tools/sunxi-tools-1.3.tar.xz
SRC_ARCHIVE      = $(tar_xz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/sunxi-tools-1.3
src_dir_name     = sunxi-tools-1.3
src_done         = $(TARGET_BUILD_DIR)/.source-done

build_dir        = $(TARGET_BUILD_DIR)/build

sysroot_dir      = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

build_target     = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)

include ../../../../build-system/core.mk


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@( cd $(SRC_DIR) ; ./autogen.sh )
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && ../$(src_dir_name)/configure \
	    --prefix=$(TOOLCHAIN_PATH)                   \
	    --mandir=$(TOOLCHAIN_PATH)/share/man
	@touch $@

$(install_target): $(build_target)
	@cd $(build_dir) && make install
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@
