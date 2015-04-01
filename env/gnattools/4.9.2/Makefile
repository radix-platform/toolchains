
COMPONENT_TARGETS  = $(TOOLCHAIN_HOST)

include ../../../build-system/config.mk


SOURCE_REQUIRES  = $(SRC_PACKAGE_DIR)/GNU/gcc/gcc-4.9.2
SOURCE_REQUIRES += $(SRC_PACKAGE_DIR)/GNU/gmp
SOURCE_REQUIRES += $(SRC_PACKAGE_DIR)/GNU/mpfr
SOURCE_REQUIRES += $(SRC_PACKAGE_DIR)/GNU/mpc

tar_bz2_archive       = $(SRC_PACKAGE_DIR)/GNU/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2
tar_bz2_archive_gmp   = $(SRC_PACKAGE_DIR)/GNU/gmp/gmp-6.0.0a.tar.bz2
tar_bz2_archive_mpfr  = $(SRC_PACKAGE_DIR)/GNU/mpfr/mpfr-3.1.2.tar.bz2
tar_gz_archive_mpc    = $(SRC_PACKAGE_DIR)/GNU/mpc/mpc-1.0.3.tar.gz
src_dir               = gcc-4.9.2
build_dir             = $(TARGET_BUILD_DIR)/build

src_done       = $(TARGET_BUILD_DIR)/.source-done
gmp_src_done   = $(TARGET_BUILD_DIR)/.gmp-source-done
mpfr_src_done  = $(TARGET_BUILD_DIR)/.mpfr-source-done
mpc_src_done   = $(TARGET_BUILD_DIR)/.mpc-source-done
SRC_DIR        = $(TARGET_BUILD_DIR)/gcc-4.9.2
SRC_ARCHIVE    = $(tar_bz2_archive)

PATCHES        = PATCHES

  build_target = $(TARGET_BUILD_DIR)/.built
install_target = $(TARGET_BUILD_DIR)/.installed


BUILD_TARGETS = $(install_target)


include ../../../build-system/core.mk


GNATTOOLS_DEST_DIR = $(TOOLCHAINS_BASE_PATH)/_gnattools/4.9.2/usr

extra_configure_switches  = --enable-languages=c,c++,ada


$(src_done): $(SRC_ARCHIVE) $(PATCHES_DEP)
	$(UNPACK_SRC_ARCHIVE)
	$(APPLY_PATCHES)
	@touch $@

$(gmp_src_done): $(src_done)
	@echo "Expanding $(tar_bz2_archive_gmp)"
	@tar xjf $(tar_bz2_archive_gmp) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../gmp-6.0.0 gmp
	@touch $@

$(mpfr_src_done): $(src_done)
	@echo "Expanding $(tar_bz2_archive_mpfr)"
	@tar xjf $(tar_bz2_archive_mpfr) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpfr-3.1.2 mpfr
	@touch $@

$(mpc_src_done): $(src_done)
	@echo "Expanding $(tar_gz_archive_mpc)"
	@tar xzf $(tar_gz_archive_mpc) -C $(TARGET_BUILD_DIR)
	@cd $(SRC_DIR); ln -sf ../mpc-1.0.3 mpc
	@touch $@

$(build_dir): $(src_done)
	@mkdir -p $@

$(build_target): $(build_dir) $(gmp_src_done) $(mpfr_src_done) $(mpc_src_done)
	@cd $(build_dir) && ../$(src_dir)/configure       \
	  --prefix=$(GNATTOOLS_DEST_DIR)                  \
	  --build=$(shell $(BUILDSYSTEM)/canonical-build) \
	  --datadir=$(GNATTOOLS_DEST_DIR)/share           \
	  --infodir=$(GNATTOOLS_DEST_DIR)/share/info      \
	  --mandir=$(GNATTOOLS_DEST_DIR)/share/man        \
	  $(extra_configure_switches)
	@cd $(build_dir) && make
	@touch $@

$(install_target): $(build_target)
	@cd $(build_dir) && make install
	@rm -f $(GNATTOOLS_DEST_DIR)/share/info/dir
	@touch $@
