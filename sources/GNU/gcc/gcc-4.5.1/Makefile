#
# Download: http://www.gnu.org/prep/ftp.html
#
# You can use the generic url http://ftpmirror.gnu.org 
# to automatically choose a nearby and up-to-date mirror.
#
# original url: http://ftp.gnu.org/gnu/gcc/gcc-$(version)
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)

version     = 4.5.1

url         = ftp://ftp.radix.pro/sources/GNU/gcc/gcc-$(version)

tarballs    = $(addsuffix .tar.bz2, $(addprefix gcc-, $(version)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))


BUILD_TARGETS = $(tarballs) $(sha1s)


include ../../../../build-system/core.mk


.PHONY: downloads_clean


$(tarballs):
	@echo -e "\n======= Downloading source tarballs =======\n"
	@for tarball in $(tarballs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$tarball ; \
	done
	@echo -e "\n======= Create Patches =======\n"
	@( cd create-patch-4.5.1-at91sam7s-newlib && ./create.patch.sh )
	@( cd create-patch-4.5.1-dm644x-newlib && ./create.patch.sh )
	@( cd create-patch-4.5.1-mips-dspr2 && ./create.patch.sh )

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

downloads_clean:
	@rm -f $(tarballs) $(sha1s)
	@rm -f ../patches/gcc-4.5.1-at91sam7s-newlib.patch
	@rm -f ../patches/gcc-4.5.1-dm644x-newlib.patch
	@rm -f ../patches/gcc-4.5.1-mips-dspr2.patch
