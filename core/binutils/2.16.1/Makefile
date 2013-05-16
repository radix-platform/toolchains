

COMPONENT_TARGETS = $(TOOLCHAIN_AT91SAM7S_NEWLIB)


include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/GNU/binutils

tar_bz2_archive = $(SRC_PACKAGE_DIR)/GNU/binutils/binutils-2.16.1a.tar.bz2
src_dir         = binutils-2.16.1
build_dir       = $(TARGET_BUILD_DIR)/build
install_dir     = $(TOOLCHAIN_PATH)

src_done = $(SRC_DIR)/.source-done
SRC_DIR = $(TARGET_BUILD_DIR)/binutils-2.16.1
SRC_ARCHIVE = $(tar_bz2_archive)


build_target = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS = $(install_target)

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
endif


.PHONY: full


$(build_target): $(build_dir)
	@touch $@

$(install_target): full
	@touch $@

$(src_dir): $(src_done)

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_dir): $(src_dir)
	mkdir -p $@
	cd $@ && ../$</configure           \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  --disable-nls                    \
	  $(extra_configure_switches)
	$(MAKE) -C $@
	$(MAKE) -C $@ info

$(install_dir): $(build_dir)
	mkdir -p $@
	mkdir -p $(TOOLCHAIN_PATH)/include
	mkdir -p $(TOOLCHAIN_PATH)/lib
	$(MAKE) -C $< install
	cp $(TARGET_BUILD_DIR)/$(src_dir)/include/libiberty.h $(TOOLCHAIN_PATH)/include/libiberty.h
	$(MAKE) -C $< install-info
	cp $(build_dir)/libiberty/libiberty.info $(TOOLCHAIN_PATH)/share/info/libiberty.info

full: $(install_dir)
