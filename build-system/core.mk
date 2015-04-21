
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


################################################################
# Check the list of available targets for current Makefile
#
__available_targets =                                                                 \
  $(foreach arch, $(shell echo $(COMPONENT_TOOLCHAINS) | sed -e 's/x86_64/x86-64/g'), \
    $(if $(FLAVOURS),                                                                 \
      $(foreach flavour, $(FLAVOURS),                                                 \
        .target_$(arch)_$(flavour)                                                    \
       ) .target_$(arch),                                                             \
      .target_$(arch)                                                                 \
     )                                                                                \
   )

__available_targets := $(strip $(__available_targets))
__available_targets := $(sort $(__available_targets))
#
#
################################################################



#######
####### Parallel control:
#######

ifneq ($(NO_PARALLEL),)
MAKEFLAGS += -j1
.NOTPARALLEL:
endif

ifeq ($(VERBOSE),)
guiet = @
else
quiet =
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
CLEANUP_FILES += $(addprefix ., $(TOOLCHAIN))
CLEANUP_FILES += .*requires*
CLEANUP_FILES += $(SRC_DIR)
CLEANUP_FILES += $(SRC_DIR).back.??????


#######
####### Build rules:
#######

all: BUILD_TREE := true
export BUILD_TREE

all:
	@$(MAKE) local_all

#
# clean is equal to local_clean
#
clean:
	@$(MAKE) local_clean


__quick_targets := help local_clean downloads_clean targets-config.mk $(HACK_TARGETS)


#
# GLOBAL setup targets:
# ====================
#   These targets are built before all targets. For example, source tarballs
#   have to be downloaded before starting the build.
#
#   NOTE:
#     BUILDSYSTEM is a setup target for other directories and the BUILDSYSTEM
#     requires only '.sources' target as a setup target.
#
ifeq ($(filter %_clean,$(MAKECMDGOALS)),)
ifeq ($(shell pwd),$(BUILDSYSTEM))
__setup_targets = .sources
else
__setup_targets = .sources .build_system
endif
endif



.setup:
ifeq ($(__final__),)
.setup: $(__setup_targets)
else
.setup: .makefile
endif


# Check if Makefile has been changed:

.makefile: Makefile
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifneq ($(if $(MAKECMDGOALS),$(filter-out $(__quick_targets),$(MAKECMDGOALS)),true),)
	@touch $@
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR))$(shell pwd | grep $(BUILDSYSTEM)/3pp/sources),)
	@echo -e "\n======= New makefile ($(<F)), clean! ======="
	@$(MAKE) dist_clean
	@if $(MAKE) local_clean ; then true ; else rm -f $@ ; fi
else
	@if $(MAKE) download_clean ; then true ; else rm -f $@; fi
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
ifeq ($(__final__),)
	@echo ""
	@shtool echo -e "%B################################################################%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BStart of building source requires for '%b$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))%B':%b"
	@shtool echo -e "%B#######%b"
	@$(BUILDSYSTEM)/build_src_requires $(TOP_BUILD_DIR_ABS)
	@__final__= TREE_RULE=local_all $(MAKE) TOOLCHAIN=$(TOOLCHAIN_NOARCH) FLAVOUR= -f .src_requires
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BEnd of building source requires for '%b$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))%B':%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B################################################################%b"
	@echo ""
	@touch $@
	@touch .src_requires_depend
endif
endif
endif



.build_system:
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR))$(shell pwd | grep $(BUILDSYSTEM)/3pp/sources),)
ifeq ($(shell pwd | grep $(BUILDSYSTEM)),)
	@shtool echo -e "%B################################################################%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BStart to Check the BUILDSYSTEM is ready:%b"
	@shtool echo -e "%B#######%b"
	@( cd $(BUILDSYSTEM) ; __final__= $(MAKE) TOOLCHAIN=$(TOOLCHAIN_HOST) FLAVOUR= all )
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BEnd of checking the BUILDSYSTEM.%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B################################################################%b"
endif
endif
endif



#######
####### Clean up default rules (not depend of TOOLCHAIN):
#######

dist_clean:
	@if [ -f .dist ]; then $(BUILDSYSTEM)/dist_clean $(DEST_DIR); rm .dist; fi


# NOTE:
# ====
#   Do not create directories with names that match the names of architectures!!!
#
tree_clean: .tree_clean

.tree_clean:
	@echo "Tree Clean..."
	@$(BUILDSYSTEM)/tree_clean $(addprefix ., $(TOOLCHAIN_NAMES)) $(TOP_BUILD_DIR_ABS)


#######
####### Clean all downloaded source tarballs
#######

downloads_clean: .downloads_clean

.downloads_clean:
	@echo ""
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BCleaning Up all downloaded sources...%b"
	@shtool echo -e "%B#######%b"
	@$(BUILDSYSTEM)/downloads_clean $(addprefix ., $(TOOLCHAIN_NOARCH)) $(BUILDSYSTEM)/3pp/sources
ifneq ($(wildcard $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR)),)
	@$(BUILDSYSTEM)/downloads_clean $(addprefix ., $(TOOLCHAIN_NOARCH)) $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR)
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




################################################################
#
# No '__final__' target selected:
# ==============================
#
# Parse TOOLCHAIN, HARDWARE, FLAVOUR selected in command line
# and build the list of '__final__' targets.
#
ifeq ($(__final__),)

#
# The FLAVOUR can be defined in command line.
# If command line defines empty flavour FLAVOUR= then
# we define that variable is set but has no values.
#
__cmdline_flavour_defined = $(if $(filter FLAVOUR,$(.VARIABLES)),true,false)
ifeq ($(__cmdline_flavour_defined),true)
__cmdline_flavour_value = $(FLAVOUR)
else
__cmdline_flavour_value =
endif


##################################################
# -----------+---------+-------------------+-----
#  TOOLCHAIN | FLAVOUR | FLAVOUR has VALUE | REF
# -----------+---------+-------------------+-----
#    defined | defined |         no        | (0)
#    defined | defined |         yes       | (1)
#    defined |    ~    |         ~         | (2)
#       ~    | defined |         no        | (3)
#       ~    | defined |         yes       | (4)
#       ~    |    ~    |         ~         | (5)
# -----------+---------+-------------------+-----
##################################################

ifeq ($(TOOLCHAIN),)
ifeq ($(__cmdline_flavour_defined),false)
ifeq ($(FLAVOUR),)
# (5) then we loop over all available flavours
__target_args = $(__available_targets)
endif
else
ifneq ($(FLAVOUR),)
# (4) then we use only one defined flavour
__target_args = $(foreach toolchain,                                                          \
                    $(shell echo $(COMPONENT_TOOLCHAINS) | sed -e 's/x86_64/x86-64/g'),       \
                    .target_$(toolchain)_$(FLAVOUR)                                           \
                 )
else
# (3) then we define flavour as empty
__target_args = $(foreach toolchain,                                                          \
                    $(shell echo $(COMPONENT_TOOLCHAINS) | sed -e 's/x86_64/x86-64/g'),       \
                    .target_$(toolchain)                                                      \
                 )
endif
endif
else
ifeq ($(__cmdline_flavour_defined),false)
ifeq ($(FLAVOUR),)
# (2) then we loop over all available flavours
__target_args = .target_$(TOOLCHAIN) $(if $(FLAVOURS), $(foreach flavour, $(FLAVOURS), .target_$(TOOLCHAIN)_$(flavour)),)
endif
else
ifneq ($(FLAVOUR),)
# (1) then we use only one defined flavour
__target_args = .target_$(TOOLCHAIN)_$(FLAVOUR)
else
# (0) then we define flavour as empty
__target_args = .target_$(TOOLCHAIN)
endif
endif
endif


__target_args := $(strip $(__target_args))


__targets = $(filter $(__target_args), $(__available_targets))

# Now we have to sort targets for that the main targets should be built before flavours!
__targets := $(sort $(__targets))


ifeq ($(__targets),)
$(error Error: Selected combination [TOOLCHAIN=$(TOOLCHAIN), FLAVOUR=$(FLAVOUR)] is invalid for this Makefile)
endif


$(__targets): .setup

local_all: GOAL = local_all
local_all: $(__targets)

local_clean: GOAL = local_clean
local_clean: $(__targets)


.target_%: TOOLCHAIN = $(shell echo $(word 2, $(subst _, , $@)) | sed -e 's/x86-64/x86_64/g')
.target_%: FLAVOUR = $(word 3, $(subst _, , $@))
.target_%:
	@echo ""
	@echo "======="
	@echo "======= TOOLCHAIN: $(TOOLCHAIN); FLAVOUR =$(if $(FLAVOUR), $(FLAVOUR));  ====="
	@echo "======="
	@__final__=true $(MAKE) TOOLCHAIN=$(TOOLCHAIN) FLAVOUR=$(FLAVOUR) $(GOAL)

else
#
################################################################
#
# The '__final__' target is defined, run the build process.


# Target is selected, build it

ifneq ($(NO_CREATE_DIST_FILES),true)
local_all: CREATE_DIST_FILES = 1
endif

ifneq ($(findstring $(TOOLCHAIN),$(TOOLCHAIN_NAMES)),)
ifeq ($(shell pwd),$(BUILDSYSTEM))
$(shell mkdir -p .$(TOOLCHAIN))
else
$(shell mkdir -p .$(TOOLCHAIN)$(if $(FLAVOUR),/$(FLAVOUR)))
endif
endif

# TOOLCHAIN/FLAVOUR depended directories

ifneq ($(TOOLCHAIN),$(TOOLCHAIN_NOARCH))
ifeq ($(shell pwd),$(BUILDSYSTEM))
targetflavour = .$(TOOLCHAIN)
else
targetflavour = .$(TOOLCHAIN)$(if $(FLAVOUR),/$(FLAVOUR))
endif
else
targetflavour = $(CURDIR)
endif

TARGET_BUILD_DIR = $(targetflavour)



ifeq ($(BUILD_TREE),true)
_tree := .tree_all
else
_tree := .requires_tree
endif


local_all: $(_tree) install

local_clean:


.tree_all: $(TARGET_BUILD_DIR)/.requires
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR))$(shell pwd | grep $(BUILDSYSTEM)/3pp/sources),)
	@shtool echo -e "%B################################################################%b"
	@shtool echo -e "%B#######%b"
ifeq ($(shell pwd),$(BUILDSYSTEM))
	@shtool echo -e "%B#######%b %BStart of building requires for '%b$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))%B':%b"
else
	@shtool echo -e "%B#######%b %BStart of building requires for %bTOOLCHAIN=%B$(TOOLCHAIN) %bFLAVOUR=%B$(FLAVOUR) in '%b$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))%B':%b"
endif
	@shtool echo -e "%B#######%b"
ifeq ($(shell pwd),$(BUILDSYSTEM))
	@__final__=true TREE_RULE=local_all $(MAKE) TOOLCHAIN=$(TOOLCHAIN_HOST) FLAVOUR= -f $(TARGET_BUILD_DIR)/.requires
else
	@__final__=true TREE_RULE=local_all $(MAKE) TOOLCHAIN=$(TOOLCHAIN) FLAVOUR= -f $(TARGET_BUILD_DIR)/.requires
endif
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B#######%b %BEnd of building requires for '%b$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))%B':%b"
	@shtool echo -e "%B#######%b"
	@shtool echo -e "%B################################################################%b"
endif
endif


.requires_tree: $(TARGET_BUILD_DIR)/.requires

#######
####### Build directory dependencies into $(TARGET_BUILD_DIR)/.requires
####### file which is used as a Makefile for tree builds.
#######

$(TARGET_BUILD_DIR)/.requires_depend: $(TARGET_BUILD_DIR)/.requires ;

$(TARGET_BUILD_DIR)/.requires: .makefile
ifeq ($(filter %_clean,$(MAKECMDGOALS)),)
ifneq ($(shell pwd),$(TOP_BUILD_DIR_ABS))
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR))$(shell pwd | grep $(BUILDSYSTEM)/3pp/sources),)
ifeq ($(shell pwd),$(BUILDSYSTEM))
	@$(BUILDSYSTEM)/build_requires $(TOP_BUILD_DIR_ABS) $(TOOLCHAIN_HOST) ; wait
else
	@$(BUILDSYSTEM)/build_requires $(TOP_BUILD_DIR_ABS) $(TOOLCHAIN) $(FLAVOUR) ; wait
endif
endif
endif
endif




################################################################
#######
####### Waiting for build whole required tree:
#######

$(BUILD_TARGETS): | $(_tree)

#######
####### End of waiting for build whole required tree.
#######
################################################################

$(PRODUCT_TARGETS) : | $(BUILD_TARGETS)


#######
####### Install:
#######

install: .install
	@if [ "$$(echo .dist*)" != ".dist*" ]; then \
	  sort -o .dist.tmp -u .dist* && mv .dist.tmp .dist; \
	fi
	@rm -f .dist.*


.install: .install_builds .install_products




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

clean: local_clean

local_clean: .local_clean

.local_clean:
ifeq ($(shell pwd | grep $(TOP_BUILD_DIR_ABS)/$(SRC_PACKAGE_DIR))$(shell pwd | grep $(BUILDSYSTEM)/3pp/sources),)
ifneq ($(wildcard .$(TOOLCHAIN)),)
	@echo "Cleaning... $(TOOLCHAIN)"
	@rm -rf $(CLEANUP_FILES)
endif
endif




-include .src_requires_depend
-include $(TARGET_BUILD_DIR)/.requires_depend


endif
#
# end of ifeq ($(__final__),)
#
################################################################

### Declare some targets as phony

.PHONY: .target*
.PHONY: .setup .sources .build_system .gnat_tools

.PHONY: .tree_all .requites_tree

.PHONY: all local_all .clean local_clean clean
.PHONY: .install

.PHONY:  downloads_clean
.PHONY: .downloads_clean

.SUFFIXES:



CORE_MK = 1
endif
