#
# Download: http://www.gnu.org/prep/ftp.html
#
# You can use the generic url http://ftpmirror.gnu.org 
# to automatically choose a nearby and up-to-date mirror.
#
# original url: http://ftp.gnu.org/gnu/gcc/gcc-$(version)
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../../../build-system/config.mk


url         = $(DOWNLOAD_SERVER)/sources/GNU/gcc/gcc-$(version)

version     = 4.7.3

tarballs    = $(addsuffix .tar.bz2, $(addprefix gcc-, $(version)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/../patches/gcc-4.7.3-at91sam7s-newlib.patch
patches    += $(CURDIR)/../patches/gcc-4.7.3-dm644x-newlib.patch
patches    += $(CURDIR)/../patches/gcc-4.7.3-a1x-newlib.patch
patches    += $(CURDIR)/../patches/gcc-4.7.3-lpc17xx-multilib.patch
patches    += $(CURDIR)/../patches/gcc-4.7.3-x86_64-multilib.patch

.NOTPARALLEL: $(patches)


BUILD_TARGETS = $(tarballs) $(sha1s) $(patches)


include ../../../../build-system/core.mk


.PHONY: downloads_clean


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
	 ( cd create-patch-4.7.3-at91sam7s-newlib ; ./create.patch.sh ) ; \
	 ( cd create-patch-4.7.3-dm644x-newlib    ; ./create.patch.sh ) ; \
	 ( cd create-patch-4.7.3-a1x-newlib       ; ./create.patch.sh ) ; \
	 ( cd create-patch-4.7.3-lpc17xx-multilib ; ./create.patch.sh ) ; \
	 ( cd create-patch-4.7.3-x86_64-multilib  ; ./create.patch.sh ) ; \
	 echo -e "\n"

downloads_clean:
	@rm -f $(tarballs) $(sha1s) $(patches)
