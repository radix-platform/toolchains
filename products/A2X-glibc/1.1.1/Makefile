

COMPONENT_TARGETS = $(TOOLCHAIN_A2X_GLIBC)

export TOOLCHAIN_VERSION = 1.1.1

include ../../../build-system/config.mk

REQUIRES  = core/gcc/5.3.0^full
REQUIRES += tools/chrpath/0.16
REQUIRES += tools/u-boot/denx/2014.01
REQUIRES += tools/sunxi/sunxi-tools/1.3
REQUIRES += core/gdb/7.11

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
