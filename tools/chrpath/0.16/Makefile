

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_EGLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I486_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_EGLIBC)


COMPONENT_TARGETS += $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I486_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES  = $(SRC_PACKAGE_DIR)/tools/chrpath

tar_gz_archive   = $(SRC_PACKAGE_DIR)/tools/chrpath/chrpath-0.16.tar.gz
SRC_ARCHIVE      = $(tar_gz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/chrpath-0.16
src_dir_name     = chrpath-0.16
src_done         = $(TARGET_BUILD_DIR)/.source-done

build_dir        = $(TARGET_BUILD_DIR)/build

build_target     = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS    = $(install_target)

include ../../../build-system/core.mk


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --datadir=$(TOOLCHAIN_PATH)/share                    \
	  --docdir=$(TOOLCHAIN_PATH)/share/doc/$(src_dir_name) \
	  --mandir=$(TOOLCHAIN_PATH)/share/man                 \
	  $(extra_configure_switches)
	$(MAKE) -C $(build_dir) all
	@touch $@

$(install_target): $(build_target)
	$(MAKE) -j1 -C $(build_dir) install docdir=$(TOOLCHAIN_PATH)/share/doc/$(src_dir_name)
	@touch $@
