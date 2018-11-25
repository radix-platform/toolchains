
NO_PARALLEL = true

COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A2X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_H3_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_H5_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_S8XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_S9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_AT91SAM7S_NEWLIB)

FLAVOURS = headers full


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/newlib

ifeq ($(FLAVOUR),headers)
REQUIRES  = core/binutils/2.31.1
endif
ifeq ($(FLAVOUR),full)
REQUIRES  = core/gcc/6.5.0^static
endif

# ======= __END_OF_REQUIRES__ =======

tar_gz_archive  = $(SRC_PACKAGE_PATH)/newlib/newlib-2.5.0.20170623.tar.gz
SRC_ARCHIVE     = $(tar_gz_archive)
SRC_DIR         = $(TARGET_BUILD_DIR)/newlib-2.5.0.20170623
src_dir_name    = newlib-2.5.0.20170623
src_done        = $(TARGET_BUILD_DIR)/.source-done

build_dir       = $(TARGET_BUILD_DIR)/newlib
build_gloss_dir = $(TARGET_BUILD_DIR)/libgloss

install_dir         = $(TOOLCHAIN_PATH)
headers_install_dir = $(TOOLCHAIN_PATH)/include

headers_target  = $(TARGET_BUILD_DIR)/.headers-installed

build_target    = $(TARGET_BUILD_DIR)/.built
full_target     = $(TARGET_BUILD_DIR)/.installed



ifeq ($(FLAVOUR),headers)
BUILD_TARGETS  = $(headers_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(full_target)
endif

include ../../../build-system/core.mk


environment  = AS="$(TOOLCHAIN_PATH)/bin/$(TARGET)-as"
environment += LD="$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld"
environment += CC="$(CCACHE)$(TOOLCHAIN_PATH)/bin/$(TARGET)-gcc"
environment += AR="$(TOOLCHAIN_PATH)/bin/$(TARGET)-ar"
environment += RANLIB="$(TOOLCHAIN_PATH)/bin/$(TARGET)-ranlib"

environment += PATH_FIG2DEV="/usr/bin:/usr/X11R6/bin:/usr/share/texmf/bin"
environment += PATH="$(TOOLCHAIN_PATH)/bin:$(PATH):$(PATH_FIG2DEV)"
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A2X_NEWLIB))
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

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H3_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls

extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H5_NEWLIB))
extra_configure_switches  = --disable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls

extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S8XX_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls

extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A9XX_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls

extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S9XX_NEWLIB))
extra_configure_switches  = --disable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls

extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
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


ENABLE_LIBGLOSS_SUPPORT = yes

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB)),)
ENABLE_LIBGLOSS_SUPPORT = no
endif

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	@( cd $(SRC_DIR)/libgloss/config ; \
	   sed -i '/^INCLUDES.*=/ s,$$, -I$$(prefix)/include -I$$(prefix)/$$(target_alias)/sys-include -I$$(prefix)/$$(target_alias)/include,' default.mh ; \
	 )
	@( cd $(SRC_DIR)/newlib/libc/sys/arm ; \
	   sed -i '/^INCLUDES.*=/ s,$$, -I../../../targ-include,' Makefile.am Makefile.in ; \
	 )
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@( cd $(SRC_DIR)/libgloss/arm ; \
	   sed -i '/^INCLUDES.*=/ s,$$, -I$$(srcdir)/../../newlib/libc/machine/arm,' Makefile.in ; \
	 )
endif
	@touch $@

$(headers_target): $(src_done)
	@mkdir -p $(headers_install_dir)
	@cp -ar $(TARGET_BUILD_DIR)/$(src_dir_name)/newlib/libc/include $(TOOLCHAIN_PATH)
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@

$(build_target): $(src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/newlib/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(BUILD)                 \
	  --host=$(TARGET)                 \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  --srcdir=../$(src_dir_name)/newlib \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_dir) all
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@mkdir -p $(build_gloss_dir)
	@cd $(build_gloss_dir) && $(environment) ../$(src_dir_name)/libgloss/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(BUILD)                 \
	  --host=$(TARGET)                 \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  --srcdir=../$(src_dir_name)/libgloss \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_gloss_dir) all info
endif
	@touch $@

$(full_target): $(build_target)
	@mkdir -p $(install_dir)
	@$(environment) $(MAKE) -C $(build_dir) install
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@$(environment) $(MAKE) -C $(build_gloss_dir) install
endif
	@$(environment) $(MAKE) -C $(build_dir) pdf
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@$(environment) $(MAKE) -C $(build_gloss_dir) pdf
endif
	# ======= Install Documentation =======
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@$(environment) $(MAKE) -C $(build_gloss_dir)/doc install-info
endif
	@mkdir -p $(TOOLCHAIN_PATH)/share/doc/newlib
	@cp $(build_dir)/libc/libc.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
	@cp $(build_dir)/libm/libm.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@cp $(build_gloss_dir)/doc/porting.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
endif
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@
