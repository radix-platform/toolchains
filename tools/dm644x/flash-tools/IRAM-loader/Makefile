
COMPONENT_TARGETS = $(TOOLCHAIN_DM644X_NEWLIB)

FLAVOURS = secure nonsecure

include ../../../../build-system/config.mk

SOURCE_REQUIRES = sources/dm644x/flash-tools/IRAM-loader

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.1),)
REQUIRES  = core/gcc/4.5.1^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.2 1.0.3 1.0.4),)
REQUIRES  = core/gcc/4.7.2^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.5),)
REQUIRES  = core/gcc/4.7.3^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.6),)
REQUIRES  = core/gcc/4.8.2^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.7 1.0.8),)
REQUIRES  = core/gcc/4.9.1^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.9),)
REQUIRES  = core/gcc/4.9.2^full
endif

# ======= __END_OF_REQUIRES__ =======

VERSION = 0.0.1
tar_bz2_archive = $(SRC_PACKAGE_PATH)/dm644x/flash-tools/IRAM-loader/IRAM-loader-$(VERSION).tar.bz2
install_dir    = $(TOOLCHAIN_PATH)

SRC_DIR = $(TARGET_BUILD_DIR)/IRAM-loader-$(VERSION)
SRC_ARCHIVE = $(tar_bz2_archive)
src_done = $(SRC_DIR)/.source-done

build_target   = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed

BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)

include ../../../../build-system/core.mk

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)
environment += INFINITY=1 DEBUG=1
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
	@$(MAKE) $(environment) -C $(SRC_DIR) all
	@touch $@

$(install_target): $(build_target)
	@mkdir -p $(install_dir)/bin
	@cp -a $(SRC_DIR)/$(sprefix)IRAM-loader $(install_dir)/bin/$(sprefix)IRAM-loader
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
