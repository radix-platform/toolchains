

COMPONENT_TARGETS = $(TOOLCHAIN_DM644X_NEWLIB)

export TOOLCHAIN_VERSION = 1.1.1

include ../../../build-system/config.mk

REQUIRES  = core/gcc/5.3.0^full
REQUIRES += tools/dm644x/flash-tools/IRAM-flasher
REQUIRES += tools/dm644x/flash-tools/IRAM-loader
REQUIRES += tools/dm644x/flash-tools/NOR-flasher

# ======= __END_OF_REQUIRES__ =======

tarball_name    = $(TOOLCHAIN_DIR)-$(TOOLCHAIN_VERSION).tar.gz
tarball         = $(TARGET_BUILD_DIR)/$(tarball_name)

tarball_target  = $(TARGET_BUILD_DIR)/.tarball-created

BUILD_TARGETS   = $(tarball_target)

PRODUCT_TARGETS = $(tarball)

include ../../../build-system/core.mk


$(tarball): $(tarball_target)

$(tarball_target):
	@echo ""
	@echo "Creating $(tarball_name) tarball..."
	@cd $(TOOLCHAINS_BASE_PATH); \
	  tar -czf $(tarball_name) $(TOOLCHAIN_DIR)/$(TOOLCHAIN_VERSION)
	@mv $(TOOLCHAINS_BASE_PATH)/$(tarball_name) $(TARGET_BUILD_DIR)
	@touch $@
