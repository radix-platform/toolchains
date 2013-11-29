
COMPONENT_TARGETS  = $(TOOLCHAIN_LPC17XX_UCLIBC)

FLAVOURS = headers full

include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/uClinux/uClibc

tar_bz2_archive       = $(SRC_PACKAGE_DIR)/uClinux/uClibc/uClibc-0.9.33.2.tar.bz2
tar_gz_archive_locale = $(SRC_PACKAGE_DIR)/uClinux/uClibc/uClibc-locale-030818.tgz
full_dir              = $(TARGET_BUILD_DIR)/deflt
headers_dir           = $(TARGET_BUILD_DIR)/build

sysroot_dir  = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

src_done     = $(TARGET_BUILD_DIR)/.source-done
src_dir_name = uClibc-0.9.33.2
SRC_DIR      = $(TARGET_BUILD_DIR)/uClibc-0.9.33.2
SRC_ARCHIVE  = $(tar_bz2_archive)
PATCHES      = PATCHES

install_target = $(TARGET_BUILD_DIR)/.installed
headers_target = $(TARGET_BUILD_DIR)/.headers-installed

ifneq ($(findstring lpc17xx, $(TOOLCHAIN)),)
arch = arm
endif

CROSS_PREFIX   = $(TARGET)-

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)
environment += TARGET_ARCH=$(arch)
environment += PREFIX=$(sysroot_dir)
#ifneq ($(VERBOSE),)
environment += V=2
#endif

ifneq ($(findstring lpc17xx, $(TOOLCHAIN)),)
def_multilib = arm
multilibs    = fpu thumb thumb1 thumb2 armv7-m armv7e-m
genconfigs   = $(CURDIR)/genconfig-lpc17xx.sh
def_config   = $(CURDIR)/.config.arm
endif

configs      = $(addprefix .config., $(def_multilib) $(multilibs))

CLEANUP_FILES += .config.*


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
#environment += CFLAGS="-msoft-float"
endif



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(install_target)
endif

include ../../../build-system/core.mk



ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_EGLIBC))
endif



.PHONY: headers_install full_install


$(headers_target): headers_install
	@touch $@

$(install_target): full_install
	@touch $@

$(SRC_DIR): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@tar xzf $(tar_gz_archive_locale) -C $@/extra/locale
	$(APPLY_PATCHES)
	@touch $@

$(src_done): $(SRC_DIR)
	touch $@

$(configs):
	@$(genconfigs) $(TARGET) $(sysroot_dir) $(def_multilib) $(multilibs)

#
# NOTE: uClibc can be built only in source directory
#
ifneq ("$(JMAKE)", "")
JMAKE := -j $(JMAKE)
endif

LMAKE := $(environment) $(MAKE) $(JMAKE) -C $(SRC_DIR) CROSS_COMPILE="$(CROSS_PREFIX)"

$(headers_dir): $(src_done) $(configs)
	@mkdir -p $@
	@cp $(def_config) $@/.config
	@cp $(SRC_DIR)/Rules.mak $@/
	$(LMAKE) O=$(CURDIR)/$@ oldconfig
	$(LMAKE) O=$(CURDIR)/$@ install_headers

headers_install: $(headers_dir)

$(full_dir): $(src_done) $(configs)
	@mkdir -p $@
	@cp $(def_config) $@/.config
	@cp $(SRC_DIR)/Rules.mak $@/
	$(LMAKE) O=$(CURDIR)/$@ oldconfig
	$(LMAKE) O=$(CURDIR)/$@ all
	$(LMAKE) O=$(CURDIR)/$@ install
	$(LMAKE) O=$(CURDIR)/$@ install_utils
	@for mult in $(multilibs) ; do                                    \
	  mkdir -p $(TARGET_BUILD_DIR)/$$mult ;                           \
	  cp .config.$$mult $(TARGET_BUILD_DIR)/$$mult/.config ;          \
	  cp $(SRC_DIR)/Rules.mak $(TARGET_BUILD_DIR)/$$mult/ ;           \
	  $(LMAKE) O=$(CURDIR)/$(TARGET_BUILD_DIR)/$$mult oldconfig ;     \
	  $(LMAKE) O=$(CURDIR)/$(TARGET_BUILD_DIR)/$$mult all ;           \
	  $(LMAKE) O=$(CURDIR)/$(TARGET_BUILD_DIR)/$$mult install ;       \
	  $(LMAKE) O=$(CURDIR)/$(TARGET_BUILD_DIR)/$$mult install_utils ; \
	done
	@for mult in $(multilibs) ; do                                                                         \
	  ( cd $(sysroot_dir)/$$mult/usr ; rm -rf include ; ln -sf ../../usr/include include ) ;               \
	  ( cd $(sysroot_dir)/lib ; mkdir -p ../$$mult/lib ; ln -sf ../$$mult/lib $$mult ) ;                   \
	  ( cd $(sysroot_dir)/usr/bin ; mkdir -p ../../$$mult/usr/bin ; ln -sf ../../$$mult/usr/bin $$mult ) ; \
	  ( cd $(sysroot_dir)/usr/lib ; mkdir -p ../../$$mult/usr/lib ; ln -sf ../../$$mult/usr/lib $$mult ) ; \
	done

full_install: $(full_dir)
