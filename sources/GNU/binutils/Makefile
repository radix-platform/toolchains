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


url         = $(DOWNLOAD_SERVER)/sources/GNU/binutils

versions    = 2.34

tarballs    = $(addsuffix .tar.xz, $(addprefix binutils-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/patches/binutils-2.34-cleansweep.patch
patches    += $(CURDIR)/patches/binutils-2.34-copy-osabi.patch
patches    += $(CURDIR)/patches/binutils-2.34-export-demangle.patch
patches    += $(CURDIR)/patches/binutils-2.34-ldforcele.patch
patches    += $(CURDIR)/patches/binutils-2.34-no-config-check.patch
patches    += $(CURDIR)/patches/binutils-2.34-sec-merge-omit.patch
patches    += $(CURDIR)/patches/binutils-2.34-set-long-long.patch


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
	 ( cd create-2.34-cleansweep-patch          ; ./create.patch.sh ) ; \
	 ( cd create-2.34-copy-osabi-patch          ; ./create.patch.sh ) ; \
	 ( cd create-2.34-export-demangle-patch     ; ./create.patch.sh ) ; \
	 ( cd create-2.34-ldforcele-patch           ; ./create.patch.sh ) ; \
	 ( cd create-2.34-no-config-check-patch     ; ./create.patch.sh ) ; \
	 ( cd create-2.34-sec-merge-emit-patch      ; ./create.patch.sh ) ; \
	 ( cd create-2.34-set-long-long-patch       ; ./create.patch.sh ) ; \
	 echo -e "\n"

download_clean:
	@rm -f $(tarballs) $(sha1s) $(patches)
