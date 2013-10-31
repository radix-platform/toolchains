
COMPONENT_TARGETS = $(TOOLCHAIN_DM644X_NEWLIB) $(TOOLCHAIN_DM644X_EGLIBC)

include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/dm644x/modSign

VERSION = 00.91
tar_bz2_archive = $(SRC_PACKAGE_DIR)/dm644x/modSign/modSign-$(VERSION).tar.bz2
install_dir    = $(TOOLCHAIN_PATH)

SRC_DIR = $(TARGET_BUILD_DIR)/modSign-$(VERSION)
SRC_ARCHIVE = $(tar_bz2_archive)
src_done = $(SRC_DIR)/.source-done

build_target   = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed

BUILD_TARGETS = $(install_target)

include ../../../build-system/core.mk

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	$(MAKE) -C $(SRC_DIR) all doc
	@touch $@

$(install_target): $(build_target)
	@mkdir -p $(install_dir)/bin/keys
	@mkdir -p $(install_dir)/share/man
	@mkdir -p $(install_dir)/share/doc/ModSign
	@cp -a $(SRC_DIR)/modSign $(install_dir)/bin
	@cp -a $(SRC_DIR)/scripts/module-sign $(install_dir)/bin
	@cp -ar $(SRC_DIR)/keys $(install_dir)/bin
	@cp -ar $(SRC_DIR)/doc/man/man3 $(install_dir)/share/man
	@cp -ar $(SRC_DIR)/doc/html $(install_dir)/share/doc/ModSign
	@touch $@
