

COMPONENT_TARGETS = $(TOOLCHAIN_AT91SAM7S_NEWLIB)


include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/GNU/gdb

tar_bz2_archive  = $(SRC_PACKAGE_DIR)/GNU/gdb/gdb-6.4.tar.bz2
src_dir          = gdb-6.4
build_dir        = $(TARGET_BUILD_DIR)/build

src_done = $(SRC_DIR)/.source-done
SRC_DIR = $(TARGET_BUILD_DIR)/gdb-6.4
SRC_ARCHIVE = $(tar_bz2_archive)


  build_target = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)


BUILD_TARGETS = $(install_target)

include ../../../build-system/core.mk



ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
extra_configure_switches += --disable-libssp
endif


.PHONY: full


$(build_target): $(build_dir)
	@touch $@

$(install_target): full
	@touch $@

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_dir): $(src_done)
	mkdir -p $@
	cd $@ && $(environment) ../$(src_dir)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --target=$(TARGET)               \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	$(MAKE) $(environment) -C $@ all

full: $(build_target)
	$(MAKE) $(environment) -C $(build_dir) install
