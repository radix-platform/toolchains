
COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_EGLIBC)

FLAVOURS = headers full

include ../../../build-system/config.mk

SOURCE_REQUIRES = sources/GNU/EGLIBC/2.17.1

ifneq ($(filter $(TOOLCHAIN_VERSION),1.0.5),)

ifeq ($(FLAVOUR),headers)
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_EGLIBC))
REQUIRES  = core/linux/sunxi/3.0.52-r2
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_EGLIBC))
REQUIRES  = core/linux/mips/2.6.36
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_EGLIBC))
REQUIRES  = core/linux/davinci/2.6.36
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_EGLIBC))
REQUIRES  = core/linux/omap/2.6.36
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_EGLIBC))
REQUIRES  = core/linux/TI/omap5/glsdk/3.8.13-20140222
endif
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
REQUIRES  = core/eglibc/2.17.1-x86_32^headers
endif
endif

ifeq ($(FLAVOUR),full)
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
REQUIRES  = core/eglibc/2.17.1-x86_32^full
else
REQUIRES  = core/gcc/4.7.3^second
endif
endif

endif

# ======= __END_OF_REQUIRES__ =======

tar_bz2_archive       = $(SRC_PACKAGE_PATH)/GNU/EGLIBC/2.17.1/eglibc-2.17.1.tar.bz2
tar_bz2_archive_ports = $(SRC_PACKAGE_PATH)/GNU/EGLIBC/2.17.1/eglibc-ports-2.17.1.tar.bz2
SRC_ARCHIVE           = $(tar_bz2_archive)
SRC_DIR               = $(TARGET_BUILD_DIR)/eglibc-2.17.1
src_dir_name          = eglibc-2.17.1
src_done              = $(TARGET_BUILD_DIR)/.source-done

PATCHES      = PATCHES

full_dir              = $(TARGET_BUILD_DIR)/build-full
headers_dir           = $(TARGET_BUILD_DIR)/build-headers

sysroot_dir           = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

headers_target        = $(TARGET_BUILD_DIR)/.headers-installed
full_target           = $(TARGET_BUILD_DIR)/.installed



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(full_target)
endif

include ../../../build-system/core.mk


env_sysroot  = install_root=$(sysroot_dir)


CC           = $(CCACHE)$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc

environment  = AS=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as
environment += LD=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld
environment += CC="$(CC)"
environment += AR=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar
environment += RANLIB=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib

environment += PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)

environment += BUILD_CC="$(CCACHE)/usr/bin/gcc"

LIBSUFFIX    =

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_EGLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_EGLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_EGLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_EGLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_EGLIBC))
environment += CFLAGS="-g -O2"
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
environment += CFLAGS="-g -O2"
endif



ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_EGLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
extra_configure_switches  += --enable-add-ons=libidn,nptl,ports
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=3.0.52
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_EGLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
extra_configure_switches  += --enable-add-ons=libidn,nptl,ports
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_EGLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
extra_configure_switches  += --enable-add-ons=libidn,nptl,ports
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_EGLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
extra_configure_switches  += --enable-add-ons=libidn,nptl,ports
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-fp
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-fp
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_EGLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
extra_configure_switches  += --enable-add-ons=libidn,nptl,ports
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
extra_configure_switches   = --libdir=/usr/lib$(LIBSUFFIX)
extra_configure_switches  += --with-headers=$(sysroot_dir)/usr/include
extra_configure_switches  += --enable-add-ons=libidn,nptl
ifeq ($(FLAVOUR),headers)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches  += --with-binutils=$(TOOLCHAIN_PATH)/bin
extra_configure_switches  += --enable-kernel=2.6.36
extra_configure_switches  += --disable-profile
extra_configure_switches  += --without-gd
extra_configure_switches  += --without-cvs
extra_configure_switches  += --with-tls
extra_configure_switches  += --with-__thread
endif
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@tar xjf $(tar_bz2_archive_ports) -C $(SRC_DIR)
	@mv $(SRC_DIR)/eglibc-ports-2.17.1 $(SRC_DIR)/ports
	@touch $@

$(headers_target): $(src_done)
	@mkdir -p $(headers_dir)
	@cd $(headers_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET)             \
	  $(extra_configure_switches)
	@cd $(headers_dir) && $(MAKE) -j1 install-headers \
	                                  install-bootstrap-headers=yes $(env_sysroot)
	@cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_lib
	@cd $(headers_dir) && $(environment) $(MAKE) -j1 csu/subdir_install $(env_sysroot)
	@$(environment) $(CC) -nostdlib -nostartfiles -shared -x c /dev/null \
	                      -o $(sysroot_dir)/usr/lib$(LIBSUFFIX)/libc.so
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@

$(full_target): $(src_done)
	@mkdir -p $(full_dir)
	@echo "slibdir=/lib$(LIBSUFFIX)" >> $(full_dir)/configparms
	@cd $(full_dir) && $(env_sysroot) $(environment) ../$(src_dir_name)/configure \
	  --prefix=/usr                \
	  --build=$(BUILD)             \
	  --host=$(TARGET)             \
	  $(extra_configure_switches)
	@cd $(full_dir) && $(environment) $(MAKE) all
	@cd $(full_dir) && $(environment) $(MAKE) -j1 install $(env_sysroot)
	@rm -f $(sysroot_dir)/usr/share/info/dir
	@echo "$(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/components.txt
	@touch $@
