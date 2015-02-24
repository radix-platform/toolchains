

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_EGLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I486_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_EGLIBC)


include ../../build-system/config.mk


SOURCE_REQUIRES  = $(SRC_PACKAGE_DIR)/tools/chrpath

tar_gz_archive   = $(SRC_PACKAGE_DIR)/tools/chrpath/chrpath-0.16.tar.gz
SRC_ARCHIVE      = $(tar_gz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/chrpath-0.16
src_dir          = chrpath-0.16
build_dir        = $(TARGET_BUILD_DIR)/build


src_done         = $(SRC_DIR)/.source-done


  build_target   = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS    = $(install_target)

include ../../build-system/core.mk


.PHONY: full


$(build_target): $(build_dir)
	@touch $@

$(install_target): full
	@touch $@

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_dir): $(src_done)
	mkdir -p $@
	cd $@ && $(environment) ../$(src_dir)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --datadir=$(TOOLCHAIN_PATH)/share               \
	  --docdir=$(TOOLCHAIN_PATH)/share/doc/$(src_dir) \
	  --mandir=$(TOOLCHAIN_PATH)/share/man            \
	  $(extra_configure_switches)
	$(MAKE) -C $@ all

full: $(build_target)
	$(MAKE) -C $(build_dir) install docdir=$(TOOLCHAIN_PATH)/share/doc/$(src_dir)
