
COMPONENT_TARGETS  = $(TOOLCHAIN_A1X_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_AT91SAM7S_NEWLIB)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_NEWLIB)

COMPONENT_TARGETS += $(TOOLCHAIN_LPC17XX_UCLIBC)

COMPONENT_TARGETS += $(TOOLCHAIN_A1X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP35X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_OMAP543X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_DM644X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_BCM74X_EGLIBC)
COMPONENT_TARGETS += $(TOOLCHAIN_X86_64_EGLIBC)

FLAVOURS = static second full


include ../../../build-system/config.mk


SOURCE_REQUIRES  = sources/GNU/gcc/gcc-4.7.3
SOURCE_REQUIRES += sources/GNU/gmp
SOURCE_REQUIRES += sources/GNU/mpfr
SOURCE_REQUIRES += sources/GNU/mpc

tar_bz2_archive       = $(SRC_PACKAGE_PATH)/GNU/gcc/gcc-4.7.3/gcc-4.7.3.tar.bz2
tar_bz2_archive_gmp   = $(SRC_PACKAGE_PATH)/GNU/gmp/gmp-5.0.5.tar.bz2
tar_bz2_archive_mpfr  = $(SRC_PACKAGE_PATH)/GNU/mpfr/mpfr-2.4.2.tar.bz2
tar_gz_archive_mpc    = $(SRC_PACKAGE_PATH)/GNU/mpc/mpc-1.0.1.tar.gz
SRC_ARCHIVE           = $(tar_bz2_archive)
SRC_DIR               = $(TARGET_BUILD_DIR)/gcc-4.7.3
src_dir_name          = gcc-4.7.3
src_done              = $(TARGET_BUILD_DIR)/.source-done
gmp_src_done          = $(TARGET_BUILD_DIR)/.gmp-source-done
mpfr_src_done         = $(TARGET_BUILD_DIR)/.mpfr-source-done
mpc_src_done          = $(TARGET_BUILD_DIR)/.mpc-source-done

ifneq ($(TOOLCHAIN),)
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
PATCHES = PATCHES.at91sam7s
else
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_NEWLIB))
PATCHES = PATCHES.dm644x
else
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_NEWLIB))
PATCHES = PATCHES.a1x
else
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
PATCHES = PATCHES.lpc17xx
else
ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
PATCHES = PATCHES.x86_64
else
PATCHES = PATCHES
endif
endif
endif
endif
endif
endif

build_dir             = $(TARGET_BUILD_DIR)/build

sysroot_dir           = $(TOOLCHAIN_PATH)/$(TARGET)/sys-root

static_build_target   = $(TARGET_BUILD_DIR)/.static-built
static_install_target = $(TARGET_BUILD_DIR)/.static-installed
second_build_target   = $(TARGET_BUILD_DIR)/.second-built
second_install_target = $(TARGET_BUILD_DIR)/.second-installed
full_build_target     = $(TARGET_BUILD_DIR)/.full-built
full_install_target   = $(TARGET_BUILD_DIR)/.full-installed

environment  = PATH=$(TOOLCHAIN_PATH)/bin:$(PATH)

LIBSUFFIX    =

ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
#LIBSUFFIX    = 64
endif


ifeq ($(FLAVOUR),static)
BUILD_TARGETS = $(static_install_target)
endif

ifeq ($(FLAVOUR),second)
BUILD_TARGETS = $(second_install_target)
endif

ifeq ($(FLAVOUR),full)
BUILD_TARGETS = $(full_install_target)
endif


include ../../../build-system/core.mk


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_NEWLIB))
extra_configure_switches  = --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs
extra_configure_switches += --with-dwarf2
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --with-newlib
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_AT91SAM7S_NEWLIB))
# Configuration arm-at91sam7s-elf is obsolete.
# Specify --enable-obsolete to build it anyway.
# Support will be REMOVED in the next major release of GCC,
# unless a maintainer comes forward.
extra_configure_switches  = --enable-obsolete
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --enable-fpu=no
extra_configure_switches += --enable-nofmult=no
extra_configure_switches += --enable-26bit=no
extra_configure_switches += --enable-underscore=no
extra_configure_switches += --with-float=soft
extra_configure_switches += --with-dwarf2
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --with-newlib
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_NEWLIB))
# Configuration arm-dm644x-elf is obsolete.
# Specify --enable-obsolete to build it anyway.
# Support will be REMOVED in the next major release of GCC,
# unless a maintainer comes forward.
extra_configure_switches  = --enable-obsolete
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-float=soft
extra_configure_switches += --with-cpu=arm926ej-s
extra_configure_switches += --with-tune=arm926ej-s
extra_configure_switches += --with-dwarf2
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --with-newlib
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=http://www.radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --without-headers
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --enable-interwork
extra_configure_switches += --enable-multilib
extra_configure_switches += --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_A1X_EGLIBC))
extra_configure_switches  = --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon
extra_configure_switches += --with-abi=aapcs
extra_configure_switches += --with-dwarf2
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP35X_EGLIBC))
extra_configure_switches  = --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-cpu=cortex-a8
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-dwarf2
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_OMAP543X_EGLIBC))
extra_configure_switches  = --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-cpu=cortex-a15
extra_configure_switches += --with-arch=armv7-a
extra_configure_switches += --with-fpu=neon-vfpv4
extra_configure_switches += --with-abi=aapcs-linux
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# --without-headers replacement for --with-newlib, to make libgcc independed from glibc:
extra_configure_switches += --without-headers
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_DM644X_EGLIBC))
extra_configure_switches  = --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-float=soft
extra_configure_switches += --with-cpu=arm926ej-s
extra_configure_switches += --with-tune=arm926ej-s
#
# NOTE:
#     The arm1026ejs is default cpu for armv5te core and  commented line
#     produces warning 'arch overrides the cpu'.
#     But both arm1026ejs and arm926ejs were connected to V5TEJ architecture.
#     So, options `--with-cpu=arm926ej-s' and  `--with-tune=arm926ej-s'
#     are enough for DM644X.
#     Moreover, if both `-mcpu' and `-march' are specified, the assembler will use
#     the setting for `-mcpu', and with `-march=armv5te' creates code for arm926ej-s.
#
#extra_configure_switches += --with-arch=armv5te
#
extra_configure_switches += --with-dwarf2
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from flibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_BCM74X_EGLIBC))
extra_configure_switches  = --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-arch=mips32
extra_configure_switches += --with-float=hard
extra_configure_switches += --enable-target-optspace
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --disable-nls
# without-headers replacement, to make libgcc independed from glibc:
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --disable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-threads
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif


ifeq ($(TOOLCHAIN),$(TOOLCHAIN_X86_64_EGLIBC))
extra_configure_switches  = '--with-pkgversion=Radix $(TOOLCHAINS_VERSION)'
extra_configure_switches += '--with-bugurl=http://www.radix.pro'
extra_configure_switches += --libdir=$(TOOLCHAIN_PATH)/lib$(LIBSUFFIX)
extra_configure_switches += --with-multilib-list=m64,m32
ifeq ($(FLAVOUR),static)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --disable-threads
extra_configure_switches += --enable-languages=c
extra_configure_switches += --disable-shared
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
extra_configure_switches += --with-newlib
endif
ifeq ($(FLAVOUR),second)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --disable-libmudflap
extra_configure_switches += --disable-libssp
extra_configure_switches += --disable-libgomp
extra_configure_switches += --disable-libquadmath
extra_configure_switches += --enable-languages=c
extra_configure_switches += --enable-decimal-float=no
extra_configure_switches += --disable-nls
endif
ifeq ($(FLAVOUR),full)
extra_configure_switches += --with-sysroot=$(sysroot_dir)
extra_configure_switches += --enable-languages=c,c++
extra_configure_switches += --enable-__cxa_atexit
extra_configure_switches += --enable-shared
extra_configure_switches += --enable-nls
extra_configure_switches += --with-included-gettext
endif
endif



$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(gmp_src_done): $(src_done)
	@echo "Expanding $(tar_bz2_archive_gmp)"
	@tar xjf $(tar_bz2_archive_gmp) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../gmp-5.0.5 gmp
	@touch $@

$(mpfr_src_done): $(src_done)
	@echo "Expanding $(tar_bz2_archive_mpfr)"
	@tar xjf $(tar_bz2_archive_mpfr) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpfr-2.4.2 mpfr
	@touch $@

$(mpc_src_done): $(src_done)
	@echo "Expanding $(tar_gz_archive_mpc)"
	@tar xzf $(tar_gz_archive_mpc) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpc-1.0.1 mpc
	@touch $@

$(static_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done)
	@mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	$(environment) $(MAKE) -C $(build_dir) all
	@touch $@

$(static_install_target): $(static_build_target)
	$(MAKE) $(environment) -j1 -C $(build_dir) install
	rm -f $(TOOLCHAIN_PATH)/share/info/dir
	@touch $@

$(second_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done)
	@mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	$(environment) $(MAKE) -C $(build_dir) all
	@touch $@

$(second_install_target): $(second_build_target)
	$(MAKE) $(environment) -j1 -C $(build_dir) install
	rm -f $(TOOLCHAIN_PATH)/share/info/dir
ifneq ($(TOOLCHAIN),$(TOOLCHAIN_LPC17XX_UCLIBC))
	cp -d $(TOOLCHAIN_PATH)/$(TARGET)/lib/libgcc_s.so $(sysroot_dir)/usr/lib
	cp    $(TOOLCHAIN_PATH)/$(TARGET)/lib/libgcc_s.so.1 $(sysroot_dir)/usr/lib
endif
ifneq ($(findstring x86_64, $(TOOLCHAIN)),)
	cp -d $(TOOLCHAIN_PATH)/$(TARGET)/lib32/libgcc_s.so $(sysroot_dir)/usr/lib32
	cp    $(TOOLCHAIN_PATH)/$(TARGET)/lib32/libgcc_s.so.1 $(sysroot_dir)/usr/lib32
endif
	@touch $@

$(full_build_target): $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done)
	@mkdir -p $(build_dir)
	cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(TOOLCHAIN_PATH)       \
	  --build=$(HOST)                  \
	  --host=$(HOST)                   \
	  --target=$(TARGET)               \
	  --with-as=$(TOOLCHAIN_PATH)/bin/$(TARGET)-as \
	  --with-ld=$(TOOLCHAIN_PATH)/bin/$(TARGET)-ld \
	  --datadir=$(TOOLCHAIN_PATH)/share       \
	  --infodir=$(TOOLCHAIN_PATH)/share/info  \
	  --mandir=$(TOOLCHAIN_PATH)/share/man    \
	  $(extra_configure_switches)
	$(environment) $(MAKE) -C $(build_dir) all
	@touch $@

#
# Before installing final GCC we remove libgcc builded with second GCC.
# The final gcc doesn't install libgcc_s.so, libstdc++.so into $(sysroot_dir)/usr/{lib|lib32}
# and it is not needed.
# NOTE: if you want to install libgcc_s.so, libstdc++.so and other libraries builded with GCC
#       and placed into $(TOOLCHAIN_PATH)/{lib|lib32} during GCC installation into TARGET
#       root file system then you should change *.la files. So the lines
#
# libdir='/opt/toolchain/x86_64-PC-linux-eglibc/1.0.0/x86_64-radix-linux-gnu/lib/../lib32'
#
# where '/opt/toolchain/x86_64-PC-linux-eglibc/1.0.0/x86_64-radix-linux-gnu' is the same
#    as '$(TOOLCHAIN_PATH)/$(TARGET)'
# should be replaced by
# libdir='/usr/lib/../lib32'
#
# In the other words we hould do following
#
#	@cat $(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX)/*.la | \
#	  $(SED) -e "s|$(TOOLCHAIN_PATH)/$(TARGET)|/usr/lib$(LIBSUFFIX)|g" > \
#	  $(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX)/*.la.tmp && \
#	  mv $(TOOLCHAIN_PATH)/$(TARGET)/lib$(LIBSUFFIX)/*.la.tmp \
#	     $(target_rootfs)/usr/lib$(LIBSUFFIX)/*.la
#
# for each *.la file in the $(TOOLCHAIN_PATH)/$(TARGET)/{lib|lib32} directory.
#

$(full_install_target): $(full_build_target)
	rm -f $(sysroot_dir)/usr/lib/libgcc_s.so
	rm -f $(sysroot_dir)/usr/lib/libgcc_s.so.1
ifneq ($(findstring x86_64, $(TOOLCHAIN)),)
	rm -f $(sysroot_dir)/usr/lib32/libgcc_s.so
	rm -f $(sysroot_dir)/usr/lib32/libgcc_s.so.1
endif
	$(MAKE) $(environment) -j1 -C $(build_dir) install
	rm -f $(TOOLCHAIN_PATH)/share/info/dir
	@touch $@
