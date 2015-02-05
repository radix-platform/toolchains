
COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)

# Always include build-system/core.mk using relative path:
include build-system/core.mk

#
# This Makefile created to allow targets which defined by build-system,
# for example, cleaning all thee directories which contain Makefiles
# for byilding any TOOLCHAINS components can be done by following
# command:
#
# $ make tree_clean
#
# NOTE: the dist_clean target will be done too.
