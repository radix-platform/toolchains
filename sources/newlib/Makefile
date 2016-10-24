#
# Project Home:
# ============
# http://www.sourceware.org/newlib/
#
# Source snapshots:
# ================
# ftp://sources.redhat.com/pub/newlib/newlib-1.18.0.tar.gz
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../build-system/config.mk


main_url    = ftp://sources.redhat.com/pub/newlib
url         = $(DOWNLOAD_SERVER)/sources/newlib

versions    = 1.20.0 2.3.0.20160226

tarballs    = $(addsuffix .tar.gz, $(addprefix newlib-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/patches/newlib-1.20.0-arm-cross.patch
patches    += $(CURDIR)/patches/newlib-2.3.0.20160226-arm-cross.patch
packages    = $(CURDIR)/newlib-1.20.0-arm-cross.tar.gz
packages   += $(CURDIR)/newlib-2.3.0.20160226-arm-cross.tar.gz

.NOTPARALLEL: $(patches)


BUILD_TARGETS = $(tarballs) $(sha1s) $(patches)


include ../../build-system/core.mk


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
	 ( cd create-newlib-1.18.0-patch         ; ./create.pkg.sh ) ; \
	 ( cd create-newlib-1.20.0-patch         ; ./create.pkg.sh ) ; \
	 ( cd create-newlib-2.3.0.20160226-patch ; ./create.pkg.sh ) ; \
	 echo -e "\n"

download_clean:
	@rm -f $(tarballs) $(sha1s) $(patches) $(packages)
