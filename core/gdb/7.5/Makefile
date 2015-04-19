

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_NEWLIB)

COMPONENT_TARGETS += $(TOOLCHAIN_A1X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_EGLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_EGLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/GNU/gdb

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.5),)
REQUIRES  = core/gcc/4.7.3^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.6),)
REQUIRES  = core/gcc/4.8.2^full
endif

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.7 1.0.8),)
REQUIRES  = core/gcc/4.9.1^full
endif

# ======= __END_OF_REQUIRES__ =======

tar_gz_archive   = $(SRC_PACKAGE_PATH)/GNU/gdb/gdb-7.5.tar.gz
SRC_ARCHIVE      = $(tar_gz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/gdb-7.5
src_dir_name     = gdb-7.5
src_done         = $(TARGET_BUILD_DIR)/.source-done

build_dir        = $(TARGET_BUILD_DIR)/build

sysroot_dir      = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

build_target     = $(TARGET_BUILD_DIR)/.built
install_target   = $(TARGET_BUILD_DIR)/.installed


environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)


BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)


include ../../../build-system/core.mk



ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_EGLIBC))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_EGLIBC))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-cpu=cortex-a7
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_EGLIBC))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-cpu=cortex-a15
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --target=$(TARGET)               \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	@$(MAKE) $(environment) -C $(build_dir) all
	@touch $@

$(install_target): $(build_target)
	@$(MAKE) $(environment) -j1 -C $(build_dir) install
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
