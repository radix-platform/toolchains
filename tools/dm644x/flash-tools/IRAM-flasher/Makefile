
COMPONENT_TARGETS = $(TOOLCHAIN_DM644X_NEWLIB)

FLAVOURS = secure nonsecure

include ../../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/dm644x/flash-tools/IRAM-flasher

VERSION = 0.0.1
tar_bz2_archive = $(SRC_PACKAGE_DIR)/dm644x/flash-tools/IRAM-flasher/IRAM-flasher-$(VERSION).tar.bz2
install_dir    = $(TOOLCHAIN_PATH)

SRC_DIR = $(TARGET_BUILD_DIR)/IRAM-flasher-$(VERSION)
SRC_ARCHIVE = $(tar_bz2_archive)
src_done = $(SRC_DIR)/.source-done

build_target   = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed

BUILD_TARGETS = $(install_target)

include ../../../../build-system/core.mk

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)
environment += CROSSCOMPILE=$(TOOLCHAIN_PATH)/bin/$(TARGET)-
ifeq ($(FLAVOUR),secure)
environment += SECURE=1
endif

ifeq ($(FLAVOUR),secure)
sprefix = s
endif

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	$(MAKE) $(environment) -C $(SRC_DIR) all
	@touch $@

$(install_target): $(build_target)
	@mkdir -p $(install_dir)/bin/boot-data
ifeq ($(FLAVOUR),secure)
	@$(environment) module-sign uart $(install_dir)/bin/boot-data/$(sprefix)IRAM-flasher.uart-pkh
	@$(environment) \
	  module-sign load $(SRC_DIR)/IRAM-flasher.bin \
	                   $(install_dir)/bin/boot-data/$(sprefix)IRAM-flasher.module
else
	@cp -a $(SRC_DIR)/IRAM-flasher.bin $(install_dir)/bin/boot-data/$(sprefix)IRAM-flasher.bin
endif
	@cp -a $(SRC_DIR)/IRAM-flasher.entry $(install_dir)/bin/boot-data/$(sprefix)IRAM-flasher.entry
	@touch $@
