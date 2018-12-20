

COMPONENT_TARGETS  = $(TOOLCHAIN_ARM32_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A33XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_A9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_H5_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_S9XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_RK33XX_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_AT91SAM7S_NEWLIB)

FLAVOURS = nano full


include ../../../build-system/config.mk


SOURCE_REQUIRES = sources/newlib

ifeq ($(FLAVOUR),nano)
REQUIRES  = core/gcc/7.3.0^static
endif
ifeq ($(FLAVOUR),full)
REQUIRES  = core/newlib/3.0.0-20180831^nano
endif

# ======= __END_OF_REQUIRES__ =======

tar_gz_archive     = $(SRC_PACKAGE_PATH)/newlib/newlib-3.0.0.20180831.tar.gz
SRC_ARCHIVE        = $(tar_gz_archive)
SRC_DIR            = $(TARGET_BUILD_DIR)/newlib-3.0.0.20180831
src_dir_name       = newlib-3.0.0.20180831
src_done           = $(TARGET_BUILD_DIR)/.source-done

PATCHES            = PATCHES

build_dir          = $(TARGET_BUILD_DIR)/newlib
build_gloss_dir    = $(TARGET_BUILD_DIR)/libgloss
build_nano_dir     = $(TARGET_BUILD_DIR)/nano

install_dir        = $(TOOLCHAIN_PATH)/$(TARGET)

build_nano_target  = $(TARGET_BUILD_DIR)/.nano-built
nano_target        = $(TARGET_BUILD_DIR)/.nano-installed

build_target       = $(TARGET_BUILD_DIR)/.built
full_target        = $(TARGET_BUILD_DIR)/.installed



ifeq ($(FLAVOUR),nano)
BUILD_TARGETS  = $(build_nano_target)
BUILD_TARGETS += $(nano_target)
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
environment += TARGET_CFLAGS="-g -O2 -ffunction-sections -fdata-sections"
environment += CPPFLAGS="-I$(TOOLCHAIN_PATH)/$(TARGET)/include"


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_ARM32_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls
ifeq ($(FLAVOUR),full)
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif
ifeq ($(FLAVOUR),nano)
extra_configure_switches += --enable-newlib-reent-small
extra_configure_switches += --disable-newlib-fvwrite-in-streamio
extra_configure_switches += --disable-newlib-fseek-optimization
extra_configure_switches += --disable-newlib-wide-orient
extra_configure_switches += --enable-newlib-nano-malloc
extra_configure_switches += --disable-newlib-unbuf-stream-opt
extra_configure_switches += --enable-lite-exit
extra_configure_switches += --enable-newlib-global-atexit
extra_configure_switches += --enable-newlib-nano-formatted-io
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A33XX_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls
ifeq ($(FLAVOUR),full)
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif
ifeq ($(FLAVOUR),nano)
extra_configure_switches += --enable-newlib-reent-small
extra_configure_switches += --disable-newlib-fvwrite-in-streamio
extra_configure_switches += --disable-newlib-fseek-optimization
extra_configure_switches += --disable-newlib-wide-orient
extra_configure_switches += --enable-newlib-nano-malloc
extra_configure_switches += --disable-newlib-unbuf-stream-opt
extra_configure_switches += --enable-lite-exit
extra_configure_switches += --enable-newlib-global-atexit
extra_configure_switches += --enable-newlib-nano-formatted-io
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A9XX_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls
ifeq ($(FLAVOUR),full)
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif
ifeq ($(FLAVOUR),nano)
extra_configure_switches += --enable-newlib-reent-small
extra_configure_switches += --disable-newlib-fvwrite-in-streamio
extra_configure_switches += --disable-newlib-fseek-optimization
extra_configure_switches += --disable-newlib-wide-orient
extra_configure_switches += --enable-newlib-nano-malloc
extra_configure_switches += --disable-newlib-unbuf-stream-opt
extra_configure_switches += --enable-lite-exit
extra_configure_switches += --enable-newlib-global-atexit
extra_configure_switches += --enable-newlib-nano-formatted-io
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_H5_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls
ifeq ($(FLAVOUR),full)
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif
ifeq ($(FLAVOUR),nano)
extra_configure_switches += --enable-newlib-reent-small
extra_configure_switches += --disable-newlib-fvwrite-in-streamio
extra_configure_switches += --disable-newlib-fseek-optimization
extra_configure_switches += --disable-newlib-wide-orient
extra_configure_switches += --enable-newlib-nano-malloc
extra_configure_switches += --disable-newlib-unbuf-stream-opt
extra_configure_switches += --enable-lite-exit
extra_configure_switches += --enable-newlib-global-atexit
extra_configure_switches += --enable-newlib-nano-formatted-io
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_S9XX_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls
ifeq ($(FLAVOUR),full)
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif
ifeq ($(FLAVOUR),nano)
extra_configure_switches += --enable-newlib-reent-small
extra_configure_switches += --disable-newlib-fvwrite-in-streamio
extra_configure_switches += --disable-newlib-fseek-optimization
extra_configure_switches += --disable-newlib-wide-orient
extra_configure_switches += --enable-newlib-nano-malloc
extra_configure_switches += --disable-newlib-unbuf-stream-opt
extra_configure_switches += --enable-lite-exit
extra_configure_switches += --enable-newlib-global-atexit
extra_configure_switches += --enable-newlib-nano-formatted-io
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_RK33XX_NEWLIB))
extra_configure_switches  = --enable-multilib
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls
ifeq ($(FLAVOUR),full)
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif
ifeq ($(FLAVOUR),nano)
extra_configure_switches += --enable-newlib-reent-small
extra_configure_switches += --disable-newlib-fvwrite-in-streamio
extra_configure_switches += --disable-newlib-fseek-optimization
extra_configure_switches += --disable-newlib-wide-orient
extra_configure_switches += --enable-newlib-nano-malloc
extra_configure_switches += --disable-newlib-unbuf-stream-opt
extra_configure_switches += --enable-lite-exit
extra_configure_switches += --enable-newlib-global-atexit
extra_configure_switches += --enable-newlib-nano-formatted-io
endif
endif

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches  = --enable-multilib
extra_configure_switches += --enable-fpu=no
extra_configure_switches += --enable-nofmult=no
extra_configure_switches += --enable-26bit=no
extra_configure_switches += --enable-underscore=no
extra_configure_switches += --with-gnu-as
extra_configure_switches += --with-gnu-ld
extra_configure_switches += --disable-nls
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-newlib-supplied-sycalls
ifeq ($(FLAVOUR),full)
extra_configure_switches += --enable-newlib-io-long-long
extra_configure_switches += --enable-newlib-register-fini
# also NEWLIB allows:
extra_configure_switches += --enable-newlib-io-c99-formats
extra_configure_switches += --enable-newlib-io-pos-args
extra_configure_switches += --enable-newlib-multithread
endif
ifeq ($(FLAVOUR),nano)
extra_configure_switches += --enable-newlib-reent-small
extra_configure_switches += --disable-newlib-fvwrite-in-streamio
extra_configure_switches += --disable-newlib-fseek-optimization
extra_configure_switches += --disable-newlib-wide-orient
extra_configure_switches += --enable-newlib-nano-malloc
extra_configure_switches += --disable-newlib-unbuf-stream-opt
extra_configure_switches += --enable-lite-exit
extra_configure_switches += --enable-newlib-global-atexit
extra_configure_switches += --enable-newlib-nano-formatted-io
endif
endif


ENABLE_STRIP_DEBUG_INFO = no

ENABLE_LIBGLOSS_SUPPORT = yes

ifneq ($(filter $(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB)),)
ENABLE_LIBGLOSS_SUPPORT = no
endif

$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
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

$(build_nano_target): $(src_done)
	@mkdir -p $(build_nano_dir)
	@cd $(build_nano_dir) && $(environment) ../$(src_dir_name)/newlib/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(BUILD)                 \
	  --host=$(TARGET)                 \
	  --target=$(TARGET)               \
	  --infodir=$(TOOLCHAIN_PATH)/share/info \
	  --mandir=$(TOOLCHAIN_PATH)/share/man   \
	  --srcdir=../$(src_dir_name)/newlib \
	  $(extra_configure_switches)
	@$(environment) $(MAKE) -C $(build_nano_dir) all
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

$(nano_target): $(build_nano_target)
	@mkdir -p $(install_dir)
	@$(environment) $(MAKE) -C $(build_nano_dir) -j1 install
	@mkdir -p $(install_dir)/include/newlib-nano
	@install -m644 -t $(install_dir)/include/newlib-nano $(install_dir)/include/newlib.h
	@find $(install_dir)/lib -regex ".*/lib\(c\|g\|m\|rdimon\)\.a" -exec rename .a _nano.a '{}' \;
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@

$(full_target): $(build_target)
	@mkdir -p $(install_dir)
	@$(environment) $(MAKE) -C $(build_dir) -j1 install
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@$(environment) $(MAKE) -C $(build_gloss_dir) -j1 install
endif
ifeq ($(ENABLE_STRIP_DEBUG_INFO),yes)
	@find $(install_dir)/lib \( -name "*.a" -or -name "*.o" \)   \
	      -exec $(TOOLCHAIN_PATH)/bin/$(TARGET)-objcopy          \
	      -R .comment -R .note -R .debug_info -R .debug_aranges  \
	      -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev \
	      -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc '{}' \;
endif
	@$(environment) $(MAKE) -C $(build_dir) pdf
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@$(environment) $(MAKE) -C $(build_gloss_dir) pdf
endif
	# ======= Install Documentation =======
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@$(environment) $(MAKE) -C $(build_gloss_dir)/doc -j1 install-info
endif
	@mkdir -p $(TOOLCHAIN_PATH)/share/doc/newlib
	@cp $(build_dir)/libc/libc.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
	@cp $(build_dir)/libm/libm.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
ifeq ($(ENABLE_LIBGLOSS_SUPPORT),yes)
	@cp $(build_gloss_dir)/doc/porting.pdf $(TOOLCHAIN_PATH)/share/doc/newlib
endif
	@echo "  $(subst $(TOP_BUILD_DIR_ABS)/,,$(CURDIR))$(if $(FLAVOUR),:$(FLAVOUR),)" >> $(TOOLCHAIN_PATH)/README
	@touch $@
