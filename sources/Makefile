
SUBDIRS := GNU/EGLIBC/2.12.1    \
           GNU/EGLIBC/2.15.1    \
           GNU/EGLIBC/2.16.1    \
           GNU/EGLIBC/2.17.1    \
           GNU/EGLIBC/2.18.1    \
           GNU/binutils         \
           GNU/gcc              \
           GNU/gcc/gcc-4.5.1    \
           GNU/gcc/gcc-4.7.2    \
           GNU/gcc/gcc-4.7.3    \
           GNU/gcc/gcc-4.8.2    \
           GNU/gdb              \
           GNU/gmp              \
           GNU/mpc              \
           GNU/mpfr             \
           GNU/multiprecision   \
           Linux/dm644x         \
           Linux/imx6           \
           Linux/mips           \
           Linux/omap           \
           Linux/omap5-glsdk    \
           Linux/sunxi          \
           Linux/v2.6           \
           Linux/v3.x           \
           U-Boot/denx          \
           U-Boot/sunxi         \
           dm644x/flash-tools/IRAM-flasher \
           dm644x/flash-tools/IRAM-loader  \
           dm644x/flash-tools/NOR-flasher  \
           dm644x/modSign                  \
           newlib               \
           uClinux/elf2flt      \
           uClinux/uClibc


all-recursive downloads_clean-recursive:
	@set fnord $(MAKEFLAGS); amf=$$2; \
	target=`echo $@ | sed s/-recursive//`; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  echo "Making $$target in $$subdir"; \
	  local_target="$$target"; \
	  (cd $$subdir && $(MAKE) $$fnord $$local_target) \
	   || case "$$amf" in *=*) exit 1;; *k*) fail=yes;; *) exit 1;; esac; \
	done; test -z "$$fail"


all: all-recursive

downloads_clean: downloads_clean-recursive

.PHONY: all-recursive downloads_clean-recursive all downloads_clean
