

COMPONENT_TARGETS = $(TOOLCHAIN_AT91SAM7S_NEWLIB)


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/GNU/gdb

tar_gz_archive   = $(SRC_PACKAGE_PATH)/GNU/gdb/gdb-6.4.tar.gz
SRC_ARCHIVE      = $(tar_gz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/gdb-6.4
src_dir_name     = gdb-6.4
src_done         = $(TARGET_BUILD_DIR)/.source-done

build_dir        = $(TARGET_BUILD_DIR)/build

build_target     = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)


BUILD_TARGETS = $(install_target)


include ../../../build-system/core.mk



ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
extra_configure_switches += --disable-libssp
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --target=$(TARGET)               \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	$(MAKE) $(environment) -C $(build_dir) all
	@touch $@

$(install_target): $(build_target)
	$(MAKE) $(environment) -j1 -C $(build_dir) install
	@touch $@
