

COMPONENT_TARGETS = $(TOOLCHAIN_AT91SAM7S_NEWLIB)


include ../../../build-system/config.mk

SOURCE_REQUIRES = sources/GNU/binutils

tar_bz2_archive = $(SRC_PACKAGE_PATH)/GNU/binutils/binutils-2.16.1a.tar.bz2
SRC_ARCHIVE     = $(tar_bz2_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/binutils-2.16.1
src_dir_name    = binutils-2.16.1
src_done        = $(SRC_DIR)/.source-done

build_dir       = $(TARGET_BUILD_DIR)/build
install_dir     = $(TOOLCHAIN_PATH)

build_target    = $(TARGET_BUILD_DIR)/.built
install_target  = $(TARGET_BUILD_DIR)/.installed


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



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	mkdir -p $(build_dir)
	cd $(build_dir) && ../$(src_dir_name)/configure    \
	  --prefix=$(TOOLCHAIN_PATH)             \
	  --build=$(HOST)                        \
	  --host=$(HOST)                         \
	  --target=$(TARGET)                     \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  --disable-nls                          \
	  $(extra_configure_switches)
	$(MAKE) -C $(build_dir)
	$(MAKE) -C $(build_dir) info
	@touch $@

$(install_target): $(build_target)
	mkdir -p $(install_dir)
	mkdir -p $(TOOLCHAIN_PATH)/include
	mkdir -p $(TOOLCHAIN_PATH)/lib
	$(MAKE) -C $(build_dir) install
	cp $(TARGET_BUILD_DIR)/$(src_dir_name)/include/libiberty.h $(TOOLCHAIN_PATH)/include/libiberty.h
	$(MAKE) -C $(build_dir) install-info
	cp $(build_dir)/libiberty/libiberty.info $(TOOLCHAIN_PATH)/share/info/libiberty.info
	@touch $@
