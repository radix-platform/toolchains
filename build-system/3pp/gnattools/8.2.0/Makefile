
COMPONENT_TARGETS  = $(TOOLCHAIN_HOST)

include ../../../../build-system/config.mk


SOURCE_REQUIRES  = build-system/3pp/sources/GNU

# ======= __END_OF_REQUIRES__ =======

tar_xz_archive        = $(BUILDSYSTEM)/3pp/sources/GNU/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz
tar_xz_archive_gmp    = $(BUILDSYSTEM)/3pp/sources/GNU/gmp/gmp-6.1.2.tar.xz
tar_xz_archive_mpfr   = $(BUILDSYSTEM)/3pp/sources/GNU/mpfr/mpfr-4.0.1.tar.xz
tar_gz_archive_mpc    = $(BUILDSYSTEM)/3pp/sources/GNU/mpc/mpc-1.1.0.tar.gz
SRC_ARCHIVE           = $(tar_xz_archive)
SRC_DIR               = $(TARGET_BUILD_DIR)/gcc-8.2.0
src_dir_name          = gcc-8.2.0
src_done              = $(TARGET_BUILD_DIR)/.source-done
gmp_src_done          = $(TARGET_BUILD_DIR)/.gmp-source-done
mpfr_src_done         = $(TARGET_BUILD_DIR)/.mpfr-source-done
mpc_src_done          = $(TARGET_BUILD_DIR)/.mpc-source-done

PATCHES        = PATCHES

build_dir             = $(TARGET_BUILD_DIR)/build


build_target   = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS  = $(build_target)
BUILD_TARGETS += $(install_target)


include ../../../../build-system/core.mk


JOBS = -j$(NUMPROCS)

environment  = CC="$(CCACHE)/usr/bin/gcc"
environment += CC_FOR_BUILD="$(CCACHE)/usr/bin/gcc"
environment += CXX_FOR_BUILD="$(CCACHE)/usr/bin/g++"


GNATTOOLS_DEST_DIR = $(BUILDSYSTEM)/gnattools/8.2.0/usr

extra_configure_switches  = --disable-bootstrap
extra_configure_switches += --enable-languages=c,c++,ada


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(gmp_src_done): $(src_done)
	@echo "Expanding $(tar_xz_archive_gmp)"
	@tar xJf $(tar_xz_archive_gmp) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../gmp-6.1.2 gmp
	@touch $@

$(mpfr_src_done): $(src_done)
	@echo "Expanding $(tar_xz_archive_mpfr)"
	@tar xJf $(tar_xz_archive_mpfr) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpfr-4.0.1 mpfr
	@touch $@

$(mpc_src_done): $(src_done)
	@echo "Expanding $(tar_gz_archive_mpc)"
	@tar xzf $(tar_gz_archive_mpc) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpc-1.1.0 mpc
	@touch $@

$(build_target): $(src_done) $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && $(environment) ../$(src_dir_name)/configure \
	  --prefix=$(GNATTOOLS_DEST_DIR)                  \
	  --build=$(shell $(BUILDSYSTEM)/canonical-build) \
	  --datadir=$(GNATTOOLS_DEST_DIR)/share           \
	  --infodir=$(GNATTOOLS_DEST_DIR)/share/info      \
	  --mandir=$(GNATTOOLS_DEST_DIR)/share/man        \
	  $(extra_configure_switches)
	@cd $(build_dir) && make $(JOBS)
	@touch $@

$(install_target): $(build_target)
	@cd $(build_dir) && make install
	@rm -f $(GNATTOOLS_DEST_DIR)/share/info/dir
	@touch $@
