#
# WEB: http://www.uclibc.org/downloads/
#
#
# Original url: http://www.uclibc.org/downloads/
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../../build-system/config.mk


url               = $(DOWNLOAD_SERVER)/sources/uClinux/uClibc

versions          = 0.9.33.1 0.9.33.2
locale_versions   = 030818

tarballs          = $(addsuffix .tar.bz2, $(addprefix uClibc-, $(versions)))
sha1s             = $(addsuffix .sha1sum, $(tarballs))

locale_tarballs   = $(addsuffix .tgz, $(addprefix uClibc-locale-, $(locale_versions)))
locale_sha1s      = $(addsuffix .sha1sum, $(locale_tarballs))

patches     = $(CURDIR)/patches/uClibc-0.9.33.2-pth-spinlock.patch
patches    += $(CURDIR)/patches/uClibc-0.9.33.2-out-of-tree.patch
patches    += $(CURDIR)/patches/uClibc-0.9.33.2-locale.patch
patches    += $(CURDIR)/patches/uClibc-0.9.33.2-reduce-execvp-env.patch

.NOTPARALLEL: $(patches)


BUILD_TARGETS     = $(tarballs) $(locale_tarballs) $(sha1s) $(locale_sha1s) $(patches)


include ../../../build-system/core.mk


.PHONY: downloads_clean


$(tarballs):
	@echo -e "\n======= Downloading source tarballs =======" ; \
	 for tarball in $(tarballs) ; do \
	   echo "$(url)/$$tarball" | xargs -n 1 -P 100 wget $(WGET_OPTIONS) -i & \
	 done ; wait

$(locale_tarballs):
	@echo -e "\n======= Downloading locale tarballs =======" ; \
	 for tarball in $(locale_tarballs) ; do \
	   echo "$(url)/$$tarball" | xargs -n 1 -P 100 wget $(WGET_OPTIONS) -i & \
	 done ; wait

$(sha1s): $(tarballs)
	@for sha in $@ ; do \
	   echo -e "\n======= Downloading '$$sha' signature =======\n" ; \
	   echo "$(url)/$$sha" | xargs -n 1 -P 100 wget $(WGET_OPTIONS) -i & wait %1 ; \
	   touch $$sha ; \
	   echo -e "\n======= Check the '$$sha' sha1sum =======\n" ; \
	   sha1sum --check $$sha ; ret="$$?" ; \
	   if [ "$$ret" == "1" ]; then \
	     echo -e "\n======= ERROR: Bad '$$sha' sha1sum =======\n" ; \
	     exit 1 ; \
	   fi ; \
	 done

$(locale_sha1s): $(locale_tarballs)
	@for sha in $@ ; do \
	   echo -e "\n======= Downloading '$$sha' signature =======\n" ; \
	   echo "$(url)/$$sha" | xargs -n 1 -P 100 wget $(WGET_OPTIONS) -i & wait %1 ; \
	   touch $$sha ; \
	   echo -e "\n======= Check the '$$sha' sha1sum =======\n" ; \
	   sha1sum --check $$sha ; ret="$$?" ; \
	   if [ "$$ret" == "1" ]; then \
	     echo -e "\n======= ERROR: Bad '$$sha' sha1sum =======\n" ; \
	     exit 1 ; \
	   fi ; \
	 done

$(patches): $(sha1s) $(locale_sha1s)
	@echo -e "\n======= Create Patches =======\n" ; \
	 ( cd create-patch-0.9.33.2-pth-spinlock      ; ./create.patch.sh ) ; \
	 ( cd create-patch-0.9.33.2-out-of-tree       ; ./create.patch.sh ) ; \
	 ( cd create-patch-0.9.33.2-030818-locale     ; ./create.patch.sh ) ; \
	 ( cd create-patch-0.9.33.2-reduce-execvp-env ; ./create.patch.sh ) ; \
	 echo -e "\n"

downloads_clean:
	@rm -f $(tarballs) $(locale_tarballs) $(sha1s) $(locale_sha1s) $(patches)
