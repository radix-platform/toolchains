
NO_PARALLEL = true

COMPONENT_TARGETS = $(TOOLCHAIN_A2X_GLIBC)

include ../../../build-system/config.mk

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC))
REQUIRES  = core/binutils/2.25
REQUIRES += core/gcc/4.9.2:static
REQUIRES += core/linux/sunxi/sunxi-3.4-20140514
REQUIRES += core/glibc/2.21:headers
REQUIRES += core/gcc/4.9.2:second
REQUIRES += core/glibc/2.21:full
REQUIRES += core/gcc/4.9.2:full
REQUIRES += tools/chrpath/0.16
REQUIRES += core/gdb/7.9
REQUIRES += tools/u-boot/denx/2014.01
REQUIRES += tools/sunxi/sunxi-tools/1.3
endif

export TOOLCHAIN_VERSION = 1.0.9

tarball_name = $(TOOLCHAIN_DIR)-$(TOOLCHAIN_VERSION).tar.gz
tarball = $(TARGET_BUILD_DIR)/$(tarball_name)

build_requires = $(TARGET_BUILD_DIR)/.requires-built
tarball_target = $(TARGET_BUILD_DIR)/.tarball-created

BUILD_TARGETS = $(build_requires)

PRODUCT_TARGETS = $(tarball)

include ../../../build-system/core.mk


$(build_requires):
	@rm -f .$(TOOLCHAIN)-requires
	@for part in $(REQUIRES) ; do \
	  echo $$part >> .$(TOOLCHAIN)-requires ; \
	done
	$(foreach part,$(REQUIRES),\
	  $(if $(word 2, $(subst :, , $(part))),\
	    $(MAKE) -C $(TOP_BUILD_DIR)/$(word 1, $(subst :, , $(part))) TOOLCHAIN=$(TOOLCHAIN) FLAVOUR=$(word 2, $(subst :, , $(part))) local_all &&,\
	    $(MAKE) -C $(TOP_BUILD_DIR)/$(part) TOOLCHAIN=$(TOOLCHAIN) local_all &&)) true
	@touch $@

$(tarball): $(tarball_target)

$(tarball_target): $(build_requires)
	@echo ""
	@echo "Creating $(tarball_name) tarball..."
	@cp .$(TOOLCHAIN)-requires $(TOOLCHAIN_PATH)/components.txt
	@cd $(TOOLCHAINS_BASE_PATH); \
	  tar -czf $(tarball_name) $(TOOLCHAIN_DIR)/$(TOOLCHAIN_VERSION)
	@mv $(TOOLCHAINS_BASE_PATH)/$(tarball_name) $(TARGET_BUILD_DIR)
	@touch $@
