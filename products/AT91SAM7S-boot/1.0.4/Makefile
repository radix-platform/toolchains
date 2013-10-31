
NO_PARALLEL = true

COMPONENT_TARGETS = $(TOOLCHAIN_AT91SAM7S_NEWLIB)

include ../../../build-system/config.mk

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
REQUIRES  = core/binutils/2.21.1
REQUIRES += core/newlib/1.20.0:headers
REQUIRES += core/gcc/4.7.2:static
REQUIRES += core/newlib/1.20.0:full
REQUIRES += core/gcc/4.7.2:full
endif

export TOOLCHAIN_VERSION = 1.0.4

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
