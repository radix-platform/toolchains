
COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)

targets_config_mk = targets-config.mk

CLEANUP_FILES += $(targets_config_mk)

BUILD_TARGETS = $(targets_config_mk)

# CORE Makefile:

include core.mk

# Dependencies:

$(targets_config_mk):
	@echo "Creating $(targets_config_mk) ..."
	@cp $(targets_config_mk).template $@
	echo $(TOOLCHAIN_NAMES)
