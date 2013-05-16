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

main_url    = ftp://sources.redhat.com/pub/newlib
url         = ftp://ftp.radix.pro/sources/newlib

versions    = 1.14.0 1.18.0 1.20.0

tarballs    = $(addsuffix .tar.gz, $(addprefix newlib-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))


BUILD_TARGETS = $(tarballs) $(sha1s)


include ../../build-system/core.mk


.PHONY: downloads_clean


$(tarballs):
	@echo -e "\n======= Downloading source tarballs ======="
	@for tarball in $(tarballs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$tarball ; \
	done
	@( cd create-newlib-1.18.0-pkg && ./create.pkg.sh )
	@( cd create-newlib-1.20.0-pkg && ./create.pkg.sh )

$(sha1s): %.tar.gz.sha1sum : %.tar.gz
	@for sha in $@ ; do \
	  echo -e "\n======= Downloading '$$sha' signature =======\n" ; \
	  wget $(WGET_OPTIONS) -N $(url)/$$sha ; \
	  touch $$sha ; \
	  echo -e "\n======= Check the '$$sha' sha1sum =======\n" ; \
	  sha1sum --check $$sha ; ret="$$?" ; \
	  if [ "$$ret" == "1" ]; then \
	    echo -e "\n======= ERROR: Bad '$$sha' sha1sum =======\n" ; \
	    exit 1 ; \
	  fi ; \
	done

downloads_clean:
	@rm -f $(tarballs) $(sha1s)
	@rm -f newlib-1.18.0-arm-cross.tar.gz ./create-newlib-1.18.0-pkg/newlib-1.18.0-arm-cross.patch
	@rm -f newlib-1.20.0-arm-cross.tar.gz ./create-newlib-1.20.0-pkg/newlib-1.20.0-arm-cross.patch
