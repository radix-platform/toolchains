
COMPONENT_TARGETS = $(TOOLCHAIN_HOST)


include config.mk

REQUIRES  = build-system/3pp/dialog/1.3-20190808
REQUIRES += build-system/3pp/gnattools/9.3.0

# ======= __END_OF_REQUIRES__ =======


config_makefile = targets-config.mk

BUILD_TARGETS = $(config_makefile)

CLEANUP_FILES += $(config_makefile)
CLEANUP_FILES += $(CURDIR)/gnattools
CLEANUP_FILES += $(CURDIR)/sbin
CLEANUP_FILES += $(CURDIR)/etc

# CORE Makefile:

include core.mk

# Dependencies:

$(config_makefile): $(config_makefile).template
	@echo "Creating $(config_makefile) ..."
	@cp $(config_makefile).template $@
