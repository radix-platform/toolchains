#
# Download: http://www.gnu.org/prep/ftp.html
#
# You can use the generic url http://ftpmirror.gnu.org
# to automatically choose a nearby and up-to-date mirror.
#
# original url: http://ftp.gnu.org/gnu/binutils
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../../build-system/config.mk


url         = $(DOWNLOAD_SERVER)/sources/GNU/glibc

versions    = 2.23 2.24 2.25

pkgname     = glibc
suffix      = tar.xz

tarballs    = $(addsuffix .$(suffix), $(addprefix $(pkgname)-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/patches/glibc-2.23-i18n.patch
patches    += $(CURDIR)/patches/glibc-2.23-vfork-alias.patch
patches    += $(CURDIR)/patches/glibc-2.24-i18n.patch
patches    += $(CURDIR)/patches/glibc-2.25-i18n.patch
patches    += $(CURDIR)/patches/glibc-2.25-malloc-hooks.patch
patches    += $(CURDIR)/patches/glibc-2.25-sparc32-atomics.patch

.NOTPARALLEL: $(patches)


BUILD_TARGETS = $(tarballs) $(sha1s) $(patches)


include ../../../build-system/core.mk


.PHONY: download_clean


$(tarballs):
	@echo -e "\n======= Downloading source tarballs =======" ; \
	 for tarball in $(tarballs) ; do \
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

$(patches): $(sha1s)
	@echo -e "\n======= Create Patches =======\n" ; \
	 ( cd create-2.23-i18n-patch            ; ./create.patch.sh ) ; \
	 ( cd create-2.23-vfork-alias-patch     ; ./create.patch.sh ) ; \
	 ( cd create-2.24-i18n-patch            ; ./create.patch.sh ) ; \
	 ( cd create-2.25-i18n-patch            ; ./create.patch.sh ) ; \
	 ( cd create-2.25-malloc-hooks-patch    ; ./create.patch.sh ) ; \
	 ( cd create-2.25-sparc32-atomics-patch ; ./create.patch.sh ) ; \
	 echo -e "\n"

download_clean:
	@rm -f $(tarballs) $(sha1s) $(patches)
