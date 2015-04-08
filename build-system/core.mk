
# include once
ifndef CORE_MK

#######
####### helpful variables
#######

comma := ,
empty :=
space := $(empty) $(empty)


#######
####### Set up TOP_BUILD_DIR, TOP_BUILD_DIR_ABS and BUILDSYSTEM variables
#######

ifndef MAKEFILE_LIST

# Work-around for GNU make pre-3.80, which lacks MAKEFILE_LIST and $(eval ...)

TOP_BUILD_DIR := $(shell perl -e 'for ($$_ = "$(CURDIR)"; ! -d "$$_/build-system"; s!(.*)/(.*)!\1!) { $$q .= "../"; } chop $$q; print "$$q"')
ifeq ($(TOP_BUILD_DIR),)
TOP_BUILD_DIR=.
endif
export TOP_BUILD_DIR_ABS := $(shell perl -e 'for ($$_ = "$(CURDIR)"; ! -d "$$_/build-system"; s!(.*)/(.*)!\1!) { } print')
export BUILDSYSTEM := $(TOP_BUILD_DIR_ABS)/build-system

else

# Normal operation for GNU make 3.80 and above

__pop = $(patsubst %/,%,$(dir $(1)))
__tmp := $(call __pop,$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
# Special case for build-system/Makefile
ifeq ($(__tmp),.)
__tmp := ../$(notdir $(CURDIR))
endif

ifndef TOP_BUILD_DIR
TOP_BUILD_DIR := $(call __pop,$(__tmp))
endif

ifndef TOP_BUILD_DIR_ABS
TOP_BUILD_DIR_ABS := $(CURDIR)
ifneq ($(TOP_BUILD_DIR),.)
$(foreach ,$(subst /, ,$(TOP_BUILD_DIR)),$(eval TOP_BUILD_DIR_ABS := $(call __pop,$(TOP_BUILD_DIR_ABS))))
endif
export TOP_BUILD_DIR_ABS
endif

ifndef BUILDSYSTEM
export BUILDSYSTEM := $(TOP_BUILD_DIR_ABS)/$(notdir $(__tmp))
endif

endif

#######
####### Set up SOURCE PACKAGE directory:
#######

export SRC_PACKAGE_DIR      := sources
export SRC_PACKAGE_PATH     := $(TOP_BUILD_DIR)/$(SRC_PACKAGE_DIR)
export SRC_PACKAGE_PATH_ABS := $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR)



#######
####### Config:
#######

include $(BUILDSYSTEM)/config.mk

TOOLCHAIN_ALL = $(strip $(foreach t, $(filter TOOLCHAIN_%,       \
                                 $(filter-out TOOLCHAIN_ALL      \
                                              TOOLCHAIN_NAMES    \
                                              TOOLCHAIN_DIR      \
                                              TOOLCHAIN_PATH     \
                                              TOOLCHAIN_VERSION, \
                                              $(.VARIABLES))), $($(t))))

TOOLCHAIN_NAMES = $(filter-out $(TOOLCHAIN_NOARCH), $(TOOLCHAIN_ALL))

COMPONENT_TOOLCHAINS = $(TOOLCHAIN_ALL)


#######
####### Set up targets etc
#######

ifneq ($(wildcard $(BUILDSYSTEM)/targets-config.mk),)
include $(BUILDSYSTEM)/targets-config.mk
else
include $(BUILDSYSTEM)/targets-config.mk.template
endif

# Reading targets-config.mk:

# BUILD_NOARCH always enabled:
BUILD_NOARCH = true

enabled = $(filter BUILD_%, $(filter-out BUILD_TARGETS BUILD_ARCH, $(.VARIABLES)))

toolchain_filter = $(strip $(foreach t, \
                     $(strip $(foreach b, \
                       $(enabled), $(if $(filter true, $($(b))), \
                         $(subst BUILD_, TOOLCHAIN_, $(b))))), $($(t))))


# If no TOOLCHAIN set
ifeq ($(TOOLCHAIN),)

# COMPONENT_TARGETS must have a value specified in the Makefile
ifeq ($(COMPONENT_TARGETS),)
$(error Error: COMPONENT_TARGETS must have a value)
endif

# End if no TARGET set
endif

# Error ff TOOLCHAIN is invalid
ifneq ($(TOOLCHAIN),)
ifeq ($(filter $(TOOLCHAIN), $(TOOLCHAIN_ALL)),)
$(error Error: TOOLCHAIN is invalid)
endif
endif


#######
####### Filter out disabled targets
#######

COMPONENT_TARGETS := $(filter $(toolchain_filter), $(COMPONENT_TARGETS))


#######
####### Targets setup:
#######

COMPONENT_TOOLCHAINS := $(filter $(COMPONENT_TARGETS),$(COMPONENT_TOOLCHAINS))


#
# TARGET, TOOLCHAIN_PATH variables should be set up for each makefile
#

# If toolchain version is not exported then we use default one 
ifeq ($(TOOLCHAIN_VERSION),)
TOOLCHAIN_VERSION = $(TOOLCHAINS_VERSION)
endif

#
# Setup current toolchain variables
#

TOOLCHAIN_DIR  = $($(shell echo $(TOOLCHAIN) | tr '[a-z-]' '[A-Z_]')_DIR)
TOOLCHAIN_PATH = $($(shell echo $(TOOLCHAIN) | tr '[a-z-]' '[A-Z_]')_PATH)/$(TOOLCHAIN_VERSION)
TARGET         = $($(shell echo $(TOOLCHAIN) | tr '[a-z-]' '[A-Z_]')_ARCH)


#######
####### Configuration:
#######

# Build environment:

DEST_DIR_ABS           = $(TOP_BUILD_DIR_ABS)/dist

ifeq ($(NEEDS_ABS_PATHS),)
DEST_DIR               = $(TOP_BUILD_DIR)/dist
else
DEST_DIR               = $(DEST_DIR_ABS)
endif

TARGET_DEST_DIR        = $(DEST_DIR)/$(TOOLCHAIN)


#######
####### Parallel control:
#######

ifneq ($(NO_PARALLEL),)
MAKEFLAGS += -j1
.NOTPARALLEL:
endif



#######
####### Default PREFIX:
#######

PREFIX ?= $(DEST_DIR)


#######
####### Setup ccache:
#######

ifeq ($(NO_CCACHE),)
CCACHE = /usr/bin/ccache$(space)

ifeq ($(wildcard $(CCACHE)),)
$(info )
$(info #######)
$(info ####### Please install 'ccache' package)
$(info ####### or disable ccache with "NO_CCACHE=1 make ...")
$(info #######)
$(info )
$(error Error: ccache not found)
endif

ifeq ($(wildcard $(CACHED_CC_OUTPUT)),)
$(info )
$(info #######)
$(info ####### Please create directory $(CACHED_CC_OUTPUT) for cached compiler output)
$(info ####### or disable ccache with "NO_CCACHE=1 make ...")
$(info #######)
$(info )
$(error Error: cached compiler output directory doesn't exist)
endif

export CCACHE_BASEDIR = $(TOP_BUILD_DIR_ABS)
export CCACHE_DIR     = $(CACHED_CC_OUTPUT)
export CCACHE_UMASK   = 000

unexport CCACHE_PREFIX
else
CCACHE =
endif



#######
####### Cleanup files:
#######

CLEANUP_FILES += .dist.*
CLEANUP_FILES += $(addprefix ., $(TOOLCHAIN_NAMES))
CLEANUP_FILES += .*requires*
CLEANUP_FILES += $(SRC_DIR)
CLEANUP_FILES += $(SRC_DIR).back.??????



__quick_targets := help local_clean targets-config.mk $(HACK_TARGETS)


ifeq ($(filter %_clean,$(MAKECMDGOALS)),)
__setup_targets = .sources .build_system .gnat_tools $(SETUP_TARGETS)
endif


.setup:
.setup: $(__setup_targets)
.setup: .makefile


# Check if Makefile has been changed:

.makefile: Makefile
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifneq ($(if $(MAKECMDGOALS),$(filter-out $(__quick_targets),$(MAKECMDGOALS)),true),)
	@touch $@
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR))$(shell pwd | grep $(BUILDSYSTEM)/3pp/sources),)
	@echo -e "\n======= New makefile ($(<F)), clean! ======="
	$(MAKE) dist_clean
	@if $(MAKE) local_clean; then true; else rm -f $@; fi
else
	@if $(MAKE) downloads_clean; then true; else rm -f $@; fi
endif
endif
endif



#######
####### Build directory dependencies into .src_requires  which
####### is used as a Makefile for srource tarballs downloading
#######

.sources: .src_requires

.src_requires_depend: .src_requires ;

.src_requires: .makefile
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifeq ($(filter %_clean,$(MAKECMDGOALS)),)
	@echo ""
	@shtool echo -e "%B################################################################%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BStart of building source requires for%b `pwd`%B:%b"
	@shtool echo -e "%B#######%b"
	@$(BUILDSYSTEM)/build_src_requires $(TOP_BUILD_DIR_ABS)
	@TREE_RULE=local_all $(MAKE) TOOLCHAIN=$(TOOLCHAIN_NOARCH) -f .src_requires
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BEnd of building source requires for%b `pwd`%B.%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B################################################################%b"
	@echo ""
	@touch $@
	@touch .src_requires_depend
endif
endif



.build_system: .src_requires
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR))$(shell pwd | grep $(BUILDSYSTEM)/3pp/sources),)
ifeq ($(shell pwd | grep $(BUILDSYSTEM)),)
	@shtool echo -e "%B################################################################%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BStart to Check the BUILDSYSTEM is ready:%b"
	@shtool echo -e "%B#######%b"
	@( cd $(BUILDSYSTEM) ; FLAVOUR= $(MAKE) TOOLCHAIN=$(TOOLCHAIN_HOST) all )
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BEnd of checking the BUILDSYSTEM.%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B################################################################%b"
endif
endif
endif



.gnat_tools: .src_requires
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR)),)
ifeq ($(shell pwd | grep $(GNAT_TOOLS_DIR)),)
	@shtool echo -e "%B################################################################%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BStart to Check the GNAT TOOLS is ready:%b"
	@shtool echo -e "%B#######%b"
	@( cd $(TOP_BUILD_DIR_ABS)/$(GNAT_TOOLS_DIR) ; FLAVOUR= $(MAKE) TOOLCHAIN=$(TOOLCHAIN_HOST) all )
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BEnd of checking the GNAT TOOLS.%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B################################################################%b"
endif
endif
endif



#######
####### Build rules:
#######

all:
	$(MAKE) local_all

ifeq ($(TOOLCHAIN),)

ifeq ($(FLAVOUR),)
__targets = $(foreach toolchain,                                                          \
                $(shell echo $(COMPONENT_TOOLCHAINS) | sed -e 's/x86_64/x86-64/g'),       \
                     $(if $(FLAVOURS),                                                    \
                         $(foreach flavour,                                               \
                             $(FLAVOURS),                                                 \
                             .target_$(toolchain)_$(flavour)                              \
                          ),.target_$(toolchain)                                          \
                      )                                                                   \
             )
else
# if FLAVOUR is defined by command line then override FLAVOURS in Makefile:
__targets = $(foreach toolchain,                                                          \
                $(shell echo $(COMPONENT_TOOLCHAINS) | sed -e 's/x86_64/x86-64/g'),       \
                .target_$(toolchain)                                                      \
             )
endif

$(__targets): .setup

local_all: $(__targets)

local_all: $(__targets)
	@if [ "$$(echo .dist*)" != ".dist*" ]; then \
	  sort -o .dist.tmp -u .dist* && mv .dist.tmp .dist; \
	fi
	@rm -f .dist.*

.target_%: TOOLCHAIN = $(shell echo $(word 2, $(subst _, , $@)) | sed -e 's/x86-64/x86_64/g')
ifeq ($(FLAVOUR),)
# if FLAVOUR is defined by command line then override FLAVOURS in Makefile:
.target_%: FLAVOUR = $(word 3, $(subst _, , $@))
endif
.target_%: .makefile
ifeq ($(VERBOSE),)
	@echo ""
	@echo "======="
	@echo "======= TOOLCHAIN: $(TOOLCHAIN); FLAVOUR =$(if $(FLAVOUR), $(FLAVOUR));  ====="
	@echo "======="
else
	@echo ""
	@echo "======="
	@echo "======= TOOLCHAIN: $(TOOLCHAIN); FLAVOUR =$(if $(FLAVOUR), $(FLAVOUR));  ====="
	@echo "======="
endif
	@TOOLCHAIN=$(TOOLCHAIN) FLAVOUR=$(FLAVOUR) $(MAKE) local_all

# ELSE: ifeq ($(TOOLCHAIN),)
else

# Target is selected, build it

ifneq ($(NO_CREATE_DIST_FILES),true)
local_all: CREATE_DIST_FILES = 1
endif

ifneq ($(findstring $(TOOLCHAIN),$(TOOLCHAIN_NAMES)),)
$(shell mkdir -p .$(TOOLCHAIN)$(if $(FLAVOUR),/$(FLAVOUR)))
endif

# TOOLCHAIN/FLAVOUR depended directories

ifneq ($(TOOLCHAIN),$(TOOLCHAIN_NOARCH))
targetflavour = .$(TOOLCHAIN)$(if $(FLAVOUR),/$(FLAVOUR))
else
targetflavour = $(CURDIR)
endif

TARGET_BUILD_DIR = $(targetflavour)


local_all: install


# END: ifeq ($(TARGET),)
endif


#######
####### Install:
#######

install: .install


.install: .src_requires .install_builds .install_products




.install_builds: $(BUILD_TARGETS)
# Do nothing

.install_products: DO_CREATE_DIST_FILES = $(CREATE_DIST_FILES)
export DO_CREATE_DIST_FILES

.install_products: $(PRODUCT_TARGETS)
ifdef PRODUCT_TARGETS
	@$(BUILDSYSTEM)/install_targets $^ $(PREFIX)/products
endif




#######
####### Clean up default rules:
#######

dist_clean:
	@if [ -f .dist ]; then $(BUILDSYSTEM)/dist_clean $(DEST_DIR); rm .dist; fi

clean: local_clean

local_clean: .local_clean

.local_clean:
	@echo "Cleaning..."
	@rm -rf $(CLEANUP_FILES)

# NOTE:
# ====
#   Do not create directories with names that match the names of architectures!!!
#
tree_clean: .tree_clean

.tree_clean:
	@echo "Tree Clean..."
	@$(BUILDSYSTEM)/tree_clean $(addprefix ., $(TOOLCHAIN_NAMES)) $(TOP_BUILD_DIR_ABS)


### Declare some targets as phony

.PHONY: .target*
.PHONY: .setup .sources .build_system .gnat_tools
.PHONY: all local_all .clean local_clean clean
.PHONY: .install

.SUFFIXES:


ifeq ($(VERBOSE),)
guiet = @
else
quiet =
endif

#######
####### Source archive and patch handling
#######

# Patch dependency:
PATCHES_DEP = $(foreach patch,$(PATCHES),\
	$(shell $(BUILDSYSTEM)/apply_patches $(patch) -dep-))

SRC_DIR_BASE = $(dir $(SRC_DIR))

# Unpack SRC_ARCHIVE in SRC_DIR and backup old SRC_DIR:
UNPACK_SRC_ARCHIVE = \
	@echo "Expanding $(SRC_ARCHIVE)"; \
	if [ -d $(SRC_DIR) ]; then mv $(SRC_DIR) $$(mktemp -d $(SRC_DIR).bak.XXXXXX); fi; \
	mkdir -p $(SRC_DIR_BASE); \
	$(if $(findstring .rpm,$(SRC_ARCHIVE)), \
	  cd $(SRC_DIR_BASE) && rpm2cpio $(SRC_ARCHIVE) | cpio -id --quiet, \
	  $(if $(findstring .zip,$(SRC_ARCHIVE)), \
	    unzip -q -d $(SRC_DIR_BASE) $(SRC_ARCHIVE), \
	    tar $(if $(findstring .bz2,$(SRC_ARCHIVE)),-xjf, \
	             $(if $(findstring .xz,$(SRC_ARCHIVE)),-xJf, \
	             $(if $(findstring .txz,$(SRC_ARCHIVE)),-xJf,-xzf))) \
	      $(SRC_ARCHIVE) -C $(SRC_DIR_BASE))); \
	chmod -R u+w $(SRC_DIR)

# Apply patches in PATCHES on SRC_DIR_BASE:
APPLY_PATCHES = $(quiet)$(foreach patch,$(PATCHES),\
	$(BUILDSYSTEM)/apply_patches $(patch) $(SRC_DIR_BASE) &&) true

# Apply optional patches in OPT_PATCHES on SRC_DIR_BASE:
APPLY_OPT_PATCHES = $(quiet)$(foreach patch,$(OPT_PATCHES),\
	$(BUILDSYSTEM)/apply_patches $(patch) $(SRC_DIR_BASE) &&) true


# Example rule:
#
# src_done = $(SRC_DIR)/.source-done
#
# $(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
# 	$(UNPACK_SRC_ARCHIVE)
# 	$(APPLY_PATCHES)
# 	 <other stuff that needs to be done to the source,
# 	   should be empty in most cases>
# 	@touch $@


-include .src_requires_depend

CORE_MK = 1
endif
