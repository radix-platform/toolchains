#
# WEB: http://www.uclibc.org/downloads/
#
#
# Original url: http://www.uclibc.org/downloads/
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)

url               = ftp://ftp.radix.pro/sources/uClinux/uClibc

versions          = 0.9.33.1 0.9.33.2
locale_versions   = 030818

tarballs          = $(addsuffix .tar.bz2, $(addprefix uClibc-, $(versions)))
sha1s             = $(addsuffix .sha1sum, $(tarballs))

locale_tarballs   = $(addsuffix .tgz, $(addprefix uClibc-locale-, $(locale_versions)))
locale_sha1s      = $(addsuffix .sha1sum, $(locale_tarballs))


BUILD_TARGETS     = $(tarballs) $(locale_tarballs) $(sha1s) $(locale_sha1s)


include ../../../build-system/core.mk


.PHONY: downloads_clean


$(tarballs):
	@echo -e "\n======= Downloading source tarballs =======\n"
	@for tarball in $(tarballs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$tarball ; \
	done

$(locale_tarballs):
	@echo -e "\n======= Downloading source tarballs =======\n"
	@for tarball in $(locale_tarballs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$tarball ; \
	done
	@echo -e "\n======= Create Patches =======\n"
	@( cd create-patch-0.9.33.2-pth-spinlock && ./create.patch.sh )
	@( cd create-patch-0.9.33.2-out-of-tree && ./create.patch.sh )
	@( cd create-patch-0.9.33.2-030818-locale && ./create.patch.sh )

$(sha1s): %.tar.bz2.sha1sum : %.tar.bz2
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

$(locale_sha1s): %.tgz.sha1sum : %.tgz
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
	@rm -f $(tarballs) $(locale_tarballs) $(sha1s) $(locale_sha1s)
	@rm -f ./patches/uClibc-0.9.33.2-pth-spinlock.patch
	@rm -f ./patches/uClibc-0.9.33.2-out-of-tree.patch
	@rm -f ./patches/uClibc-0.9.33.2-locale.patch
