
COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../../build-system/config.mk


url         = $(DOWNLOAD_SERVER)/sources/packages/a/patchelf

versions    = 0.10.2
pkg_name    = patchelf
suffix      = tar.xz

tarballs    = $(addsuffix .$(suffix), $(addprefix $(pkg_name)-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/patches/patchelf-0.10.2-check-endianness.patch

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
	 ( cd create-0.10.2-check-endianness-patch  ; ./create.patch.sh ) ; \
	 echo -e "\n"

download_clean:
	@rm -f $(tarballs) $(sha1s) $(patches)
