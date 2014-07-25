
SUBDIRS := ../build-system       \
           A1X-boot/1.0.6        \
           AT91SAM7S-boot/1.0.6  \
           DM644X-boot/1.0.6     \
           LPC17XX-uclibc/1.0.6  \
           A1X-eglibc/1.0.6      \
           DM644X-eglibc/1.0.6   \
           IMX6-eglibc/1.0.6     \
           OMAP35X-eglibc/1.0.6  \
           OMAP543X-eglibc/1.0.6 \
           BCM74X-eglibc/1.0.6   \
           I486-eglibc/1.0.6     \
           X86_64-eglibc/1.0.6

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
