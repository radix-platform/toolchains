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

versions    = 2.16.1a 2.20.1a 2.21.1a 2.22 2.23.2 2.24

tarballs    = $(addsuffix .tar.bz2, $(addprefix binutils-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))


BUILD_TARGETS = $(tarballs) $(sha1s)


include ../../../build-system/core.mk


.PHONY: downloads_clean


$(tarballs):
	@echo -e "\n======= Downloading source tarballs =======\n"
	@for tarball in $(tarballs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$tarball ; \
	done
	@echo -e "\n======= Create Patches =======\n"
	@( cd create-patch-2.16.1-AVR && ./create.patch.sh )
	@( cd create-patch-2.20.1-mips-opcodes && ./create.patch.sh )
	@( cd create-patch-2.20.1-x86_64-multilib && ./create.patch.sh )
	@( cd create-patch-2.21.1-x86_64-multilib && ./create.patch.sh )
	@( cd create-patch-2.22-x86_64-multilib && ./create.patch.sh )
	@( cd create-patch-2.23.2-x86_64-multilib && ./create.patch.sh )
	@( cd create-patch-2.24-x86_64-multilib && ./create.patch.sh )

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
	@rm -f ./patches/binutils-2.16.1-AVR.patch
	@rm -f ./patches/binutils-2.20.1-mips-opcodes.patch
	@rm -f ./patches/binutils-2.20.1-x86_64-multilib.patch
	@rm -f ./patches/binutils-2.21.1-x86_64-multilib.patch
	@rm -f ./patches/binutils-2.22-x86_64-multilib.patch
	@rm -f ./patches/binutils-2.23.2-x86_64-multilib.patch
	@rm -f ./patches/binutils-2.24-x86_64-multilib.patch
