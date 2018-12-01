

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_H3_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_H5_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_JZ47XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_P5600_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK328X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_S8XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_S9XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK33XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_POWER8LE_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_POWER9LE_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_R1000_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I686_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES  = sources/tools/patchelf

REQUIRES  = core/gcc/7.3.0^full

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive   = $(SRC_PACKAGE_PATH)/tools/patchelf/patchelf-0.10.1.tar.xz
SRC_ARCHIVE      = $(tar_xz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/patchelf-0.10.1
src_dir_name     = patchelf-0.10.1
src_done         = $(TARGET_BUILD_DIR)/.source-done

PATCHES          = PATCHES

build_dir        = $(TARGET_BUILD_DIR)/build

build_target     = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS    = $(build_target)
BUILD_TARGETS   += $(install_target)

include ../../../build-system/core.mk


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --program-prefix=$(TARGET)-      \
	  --datadir=$(TOOLCHAIN_PATH)/share                    \
	  --docdir=$(TOOLCHAIN_PATH)/share/doc/$(src_dir_name) \
	  --mandir=$(TOOLCHAIN_PATH)/share/man                 \
	  $(extra_configure_switches)
	@$(MAKE) -C $(build_dir) all
	@touch $@

$(install_target): $(build_target)
	@$(MAKE) -j1 -C $(build_dir) install docdir=$(TOOLCHAIN_PATH)/share/doc/$(src_dir_name)
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@
