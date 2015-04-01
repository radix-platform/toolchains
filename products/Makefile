
SUBDIRS := ../build-system         \
           ../env/gnattools/4.9.2  \
           A1X-boot/1.0.9          \
           A2X-boot/1.0.9          \
           AT91SAM7S-boot/1.0.9    \
           DM644X-boot/1.0.9       \
           LPC17XX-uclibc/1.0.9    \
           \
           A1X-eglibc/1.0.9        \
           A2X-eglibc/1.0.9        \
           DM644X-eglibc/1.0.9     \
           IMX6-eglibc/1.0.9       \
           OMAP35X-eglibc/1.0.9    \
           OMAP543X-eglibc/1.0.9   \
           BCM74X-eglibc/1.0.9     \
           I486-eglibc/1.0.9       \
           X86_64-eglibc/1.0.9     \
           \
           A1X-glibc/1.0.9         \
           A2X-glibc/1.0.9         \
           BCM74X-glibc/1.0.9      \
           DM644X-glibc/1.0.9      \
           I486-glibc/1.0.9        \
           IMX6-glibc/1.0.9        \
           OMAP35X-glibc/1.0.9     \
           OMAP543X-glibc/1.0.9    \
           X86_64-glibc/1.0.9


all-recursive:
	@set fnord $(MAKEFLAGS); amf=$$2; \
	target=`echo $@ | sed s/-recursive//`; \
	list='$(SUBDIRS)'; for subdir in $$list; do \
	  echo "Making $$target in $$subdir"; \
	  local_target="$$target"; \
	  (cd $$subdir && $(MAKE) $$fnord $$local_target) \
	   || case "$$amf" in *=*) exit 1;; *k*) fail=yes;; *) exit 1;; esac; \
	done; test -z "$$fail"


all: all-recursive

.PHONY: all-recursive all
