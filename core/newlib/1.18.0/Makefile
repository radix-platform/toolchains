
NO_PARALLEL = true

COMPONENT_TARGETS  = $(TOOLCHAIN_AT91SAM7S_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_NEWLIB)

FLAVOURS = headers full


include ../../../build-system/config.mk

SOURCE_REQUIRES = $(SRC_PACKAGE_DIR)/newlib

tar_gz_archive = $(SRC_PACKAGE_DIR)/newlib/newlib-1.18.0-arm-cross.tar.gz
src_dir         = newlib-1.18.0
build_dir       = $(TARGET_BUILD_DIR)/build
install_dir     = $(TOOLCHAIN_PATH)
headers_dir     = $(TOOLCHAIN_PATH)/include

src_done = $(SRC_DIR)/.source-done
SRC_DIR = $(TARGET_BUILD_DIR)/newlib-1.18.0
SRC_ARCHIVE = $(tar_gz_archive)

  build_target = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed
headers_target = $(TARGET_BUILD_DIR)/.headers-installed

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC=$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH_FIG2DEV=/usr/bin:/usr/X11R6/bin:/usr/share/texmf/bin
environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH):$(PATH_FIG2DEV)
#                                                   =============
# need for fig2dev and documentation (see: ../.config).

environment += BUILD_CC=gcc
environment += TARGET_CFLAGS=""

ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(install_target)
endif

include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --enable-fpu=no
extra_configure_switches += --enable-nofmult=no
extra_configure_switches += --enable-26bit=no
extra_configure_switches += --enable-underscore=no
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --enable-newlib-supplied-sycalls
extra_configure_switches += --disable-shared
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --enable-newlib-supplied-sycalls
extra_configure_switches += --disable-shared
#
# also NEWLIB allows:
#
# extra_configure_switches += --enable-newlib-io-c99-formats
# extra_configure_switches += --enable-newlib-io-longlong
# extra_configure_switches += --enable-newlib-io-pos-args
# extra_configure_switches += --enable-newlib-multithread
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
	  $(extra_configure_switches)
	$(environment) $(MAKE) -C $@ all

$(install_dir): $(build_dir)
	mkdir -p $@
	$(environment) $(MAKE) -C $< install
	$(environment) $(MAKE) -C $< pdf
	mkdir -p $(TOOLCHAIN_PATH)/share/doc/newlib
	cp $</libc/libc.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
	cp $</libm/libm.pdf $(TOOLCHAIN_PATH)/share/doc/newlib

full_install: $(install_dir)
