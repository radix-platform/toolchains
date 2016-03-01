

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_NEWLIB)

COMPONENT_TARGETS += $(TOOLCHAIN_A1X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_IMX6_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_JZ47XX_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_P5600_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_RK328X_GLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_I486_GLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_GLIBC)


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/GNU/gdb

ifneq ($(filter $(TOOLCHAIN_VERSION),1.1.0),)
REQUIRES  = core/gcc/5.3.0^full
endif

# ======= __END_OF_REQUIRES__ =======

tar_gz_archive   = $(SRC_PACKAGE_PATH)/GNU/gdb/gdb-7.10.1.tar.gz
SRC_ARCHIVE      = $(tar_gz_archive)
SRC_DIR          = $(TARGET_BUILD_DIR)/gdb-7.10.1
src_dir_name     = gdb-7.10.1
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
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a8
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-tune=cortex-a7
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A1X_GLIBC)),)
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a8
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_A2X_GLIBC)),)
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-tune=cortex-a7
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_IMX6_GLIBC)),)
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a9
extra_configure_switches += --with-fpu=vfpv3
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_JZ47XX_GLIBC)),)
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch-32=mips32r2
extra_configure_switches += --with-arch-64=mips64r2
extra_configure_switches += --with-float=hard
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_P5600_GLIBC)),)
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=mips32r5
extra_configure_switches += --with-tune=p5600
extra_configure_switches += --with-float=hard
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_GLIBC)),)
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a8
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_GLIBC)),)
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-tune=cortex-a15
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_RK328X_GLIBC)),)
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --disable-libssp
extra_configure_switches += --with-arch=armv7ve
extra_configure_switches += --with-tune=cortex-a17
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_I486_GLIBC)),)
extra_configure_switches += --with-arch=i486
extra_configure_switches += --with-tune=i686
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_X86_64_GLIBC)),)
extra_configure_switches += --with-multilib-list=m64,m32
extra_configure_switches += --with-build-sysroot=$(sysroot_dir)
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)              \
	  --target=$(TARGET)                      \
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
