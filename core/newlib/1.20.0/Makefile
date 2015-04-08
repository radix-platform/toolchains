
NO_PARALLEL = true

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_AT91SAM7S_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_NEWLIB)

FLAVOURS = headers full


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/newlib

tar_gz_archive  = $(SRC_PACKAGE_PATH)/newlib/newlib-1.20.0-arm-cross.tar.gz
SRC_ARCHIVE     = $(tar_gz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/newlib-1.20.0
src_dir_name    = newlib-1.20.0
src_done        = $(TARGET_BUILD_DIR)/.source-done

build_dir       = $(TARGET_BUILD_DIR)/build

install_dir         = $(TOOLCHAIN_PATH)
headers_install_dir = $(TOOLCHAIN_PATH)/include

build_target    = $(TARGET_BUILD_DIR)/.built
headers_target  = $(TARGET_BUILD_DIR)/.headers-installed
full_target     = $(TARGET_BUILD_DIR)/.installed



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(full_target)
endif

include ../../../build-system/core.mk


environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC=$(CCACHE)$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH_FIG2DEV=/usr/bin:/usr/X11R6/bin:/usr/share/texmf/bin
environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH):$(PATH_FIG2DEV)
#                                                   =============
# need for fig2dev and documentation (see: ../.config).

environment += BUILD_CC="$(CCACHE)/usr/bin/gcc"
environment += TARGET_CFLAGS=""


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --enable-newlib-supplied-sycalls
extra_configure_switches += --disable-shared
#
# also NEWLIB allows:
#
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-longlong
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif

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



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@touch $@

$(headers_target): $(src_done)
	mkdir -p $(headers_install_dir)
	cp -ar $(TARGET_BUILD_DIR)/$(src_dir_name)/newlib/libc/include $(TOOLCHAIN_PATH)
	@touch $@

$(build_target): $(src_done)
	mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/newlib/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(BUILD)                 \
	  --host=$(TARGET)                 \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  $(extra_configure_switches)
	$(environment) $(MAKE) -C $(build_dir) all
	@touch $@

$(full_target): $(build_target)
	mkdir -p $(install_dir)
	$(environment) $(MAKE) -C $(build_dir) install
	$(environment) $(MAKE) -C $(build_dir) pdf
	mkdir -p $(TOOLCHAIN_PATH)/share/doc/newlib
	cp $(build_dir)/libc/libc.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
	cp $(build_dir)/libm/libm.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
	@touch $@
