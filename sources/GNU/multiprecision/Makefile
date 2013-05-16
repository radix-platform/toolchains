#
# Download: http://www.multiprecision.org/mpc/download
#
# original url: http://www.multiprecision.org
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)

url         = ftp://ftp.radix.pro/sources/GNU/multiprecision

versions    = 0.8.2 0.9 1.0

tarballs    = $(addsuffix .tar.gz, $(addprefix mpc-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))


BUILD_TARGETS = $(tarballs) $(sha1s)


include ../../../build-system/core.mk


.PHONY: downloads_clean


$(tarballs):
	@echo -e "\n======= Downloading source tarballs =======\n"
	@for tarball in $(tarballs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$tarball ; \
	done

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
