
NO_PARALLEL = true

COMPONENT_TARGETS  = $(TOOLCHAIN_AT91SAM7S_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_NEWLIB)

FLAVOURS = headers full


include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/newlib

tar_gz_archive = $(SRC_PACKAGE_DIR)/newlib/newlib-1.14.0.tar.gz
src_dir         = newlib-1.14.0
build_dir       = $(TARGET_BUILD_DIR)/build
install_dir     = $(TOOLCHAIN_PATH)
headers_dir     = $(TOOLCHAIN_PATH)/include

src_done = $(SRC_DIR)/.source-done
SRC_DIR = $(TARGET_BUILD_DIR)/newlib-1.14.0
SRC_ARCHIVE = $(tar_gz_archive)

  build_target = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed
headers_target = $(TARGET_BUILD_DIR)/.headers-installed

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC=$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH_FIG2DEV=/usr/X11R6/bin:/usr/share/texmf/bin
environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH):$(PATH_FIG2DEV)
#                                                   =============
# need for fig2dev and documentation (see: ../.config).

environment += BUILD_CC=gcc
environment += CFLAGS_FOR_TARGET=""

ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(install_target)
endif

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
extra_configure_switches += --without-mpfr
extra_configure_switches += --without-gmp
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
extra_configure_switches += --without-mpfr
extra_configure_switches += --without-gmp
endif

.PHONY: headers_install full_install

$(headers_target): headers_install
	@touch $@

$(build_target): $(build_dir)
	@touch $@

$(install_target): full_install
	@touch $@

$(src_dir): $(src_done)

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(headers_dir): $(src_dir)
	mkdir -p $@
	cp -ar $(TARGET_BUILD_DIR)/$(src_dir)/newlib/libc/include $(TOOLCHAIN_PATH)

headers_install: $(headers_dir)


$(build_dir): $(src_dir)
	mkdir -p $@
	cd $@ && $(environment) ../$</newlib/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(BUILD)                 \
	  --host=$(TARGET)                 \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  --disable-libada                 \
	  --disable-libssp                 \
	  $(extra_configure_switches)
	$(MAKE) -C $@ all

$(install_dir): $(build_dir)
	mkdir -p $@
#	$(MAKE) $(environment) -C $< install
	$(MAKE) $(environment) -C $< info
	$(MAKE) $(environment) -C $< install-info

full_install: $(install_dir)
