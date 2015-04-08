
COMPONENT_TARGETS = $(TOOLCHAIN_DM644X_NEWLIB)

FLAVOURS = secure nonsecure

include ../../../../build-system/config.mk

SOURCE_REQUIRES = sources/dm644x/flash-tools/NOR-flasher

VERSION = 0.0.1
tar_bz2_archive = $(SRC_PACKAGE_PATH)/dm644x/flash-tools/NOR-flasher/NOR-flasher-$(VERSION).tar.bz2
install_dir    = $(TOOLCHAIN_PATH)

SRC_DIR = $(TARGET_BUILD_DIR)/NOR-flasher-$(VERSION)
SRC_ARCHIVE = $(tar_bz2_archive)
src_done = $(SRC_DIR)/.source-done

build_target   = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed

BUILD_TARGETS = $(install_target)

include ../../../../build-system/core.mk

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)
environment += INFINITY=0 DEBUG=0
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
	@mkdir -p $(install_dir)/bin
	@cp -a $(SRC_DIR)/$(sprefix)NOR-flasher $(install_dir)/bin/$(sprefix)NOR-flasher
	@touch $@
