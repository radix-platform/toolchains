

COMPONENT_TARGETS = $(TOOLCHAIN_OMAP543X_GLIBC)

export TOOLCHAIN_VERSION = 1.3.4

include ../../../build-system/config.mk

REQUIRES  = core/gcc/7.3.0^full
REQUIRES += tools/chrpath/0.16
REQUIRES += tools/patchelf/0.10.1
REQUIRES += tools/u-boot/denx/2014.01
REQUIRES += core/gdb/8.2

# ======= __END_OF_REQUIRES__ =======

tarball_name    = $(TOOLCHAIN_DIR)-$(TOOLCHAIN_VERSION).tar.xz
tarball         = $(TARGET_BUILD_DIR)/$(tarball_name)

tarball_target  = $(TARGET_BUILD_DIR)/.tarball-created

BUILD_TARGETS   = $(tarball_target)

PRODUCT_TARGETS = $(tarball)

include ../../../build-system/core.mk


$(tarball): $(tarball_target)

$(tarball_target):
	@echo ""
	@echo "Creating $(tarball_name) tarball..."
	@cd $(TOOLCHAINS_BASE_PATH) ; \
	  tar -cf - $(TOOLCHAIN_DIR)/$(TOOLCHAIN_VERSION) | xz --threads=0 > $(tarball_name)
	@mv $(TOOLCHAINS_BASE_PATH)/$(tarball_name) $(TARGET_BUILD_DIR)
	@touch $@
