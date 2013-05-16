

COMPONENT_TARGETS = $(TOOLCHAIN_OMAP35X_EGLIBC)

include ../../../build-system/config.mk

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_EGLIBC))
REQUIRES  = core/binutils/2.20.1
REQUIRES += core/gcc/4.5.1:static
REQUIRES += core/linux/omap/2.6.36
REQUIRES += core/eglibc/2.12.1:headers
REQUIRES += core/gcc/4.5.1:second
REQUIRES += core/eglibc/2.12.1:full
REQUIRES += core/gcc/4.5.1:full
endif

export TOOLCHAIN_VERSION = 1.0.1

tarball_name = $(TOOLCHAIN_DIR)-$(TOOLCHAIN_VERSION).tar.gz
tarball = $(TARGET_BUILD_DIR)/$(tarball_name)

BUILD_TARGETS = build_requires

PRODUCT_TARGETS = $(tarball)

include ../../../build-system/core.mk

.PHONY: build_requires create_tarball

build_requires:
	@rm -f .$(TOOLCHAIN)-requires
	@for part in $(REQUIRES) ; do \
	  echo $$part >> .$(TOOLCHAIN)-requires ; \
	done
	$(foreach part,$(REQUIRES),\
	  $(if $(word 2, $(subst :, , $(part))),\
	    $(MAKE) -C $(TOP_BUILD_DIR)/$(word 1, $(subst :, , $(part))) TOOLCHAIN=$(TOOLCHAIN) FLAVOUR=$(word 2, $(subst :, , $(part))) local_all &&,\
	    $(MAKE) -C $(TOP_BUILD_DIR)/$(part) TOOLCHAIN=$(TOOLCHAIN) local_all &&)) true

$(tarball): create_tarball

create_tarball: build_requires
	@echo ""
	@echo "Creating $(tarball_name) tarball..."
	@cp .$(TOOLCHAIN)-requires $(TOOLCHAIN_PATH)/components.txt
	@cd $(TOOLCHAINS_BASE_PATH); \
	  tar -czf $(tarball_name) $(TOOLCHAIN_DIR)/$(TOOLCHAIN_VERSION)
	@mv $(TOOLCHAINS_BASE_PATH)/$(tarball_name) $(TARGET_BUILD_DIR)
