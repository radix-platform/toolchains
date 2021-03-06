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

version     = 5.3.0

tarballs    = $(addsuffix .tar.bz2, $(addprefix gcc-, $(version)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/../patches/gcc-5.3.0-at91sam7s-newlib.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-dm644x-newlib.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-a1x-newlib.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-a2x-newlib.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-lpc17xx-multilib.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-x86_64-multilib.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-bcm74x-libgo.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-jz47xx-libgo.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-p5600-libgo.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-i386-66782.patch
patches    += $(CURDIR)/../patches/gcc-5.3.0-i386-69140.patch


.NOTPARALLEL: $(patches)


BUILD_TARGETS = $(tarballs) $(sha1s) $(patches)


include ../../../../build-system/core.mk


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
	 ( cd create-5.3.0-at91sam7s-newlib-patch ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-dm644x-newlib-patch    ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-a1x-newlib-patch       ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-a2x-newlib-patch       ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-lpc17xx-multilib-patch ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-x86_64-multilib-patch  ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-i386-66782-patch       ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-i386-69140-patch       ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-bcm74x-libgo-patch     ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-jz47xx-libgo-patch     ; ./create.patch.sh ) ; \
	 ( cd create-5.3.0-p5600-libgo-patch      ; ./create.patch.sh ) ; \
	 echo -e "\n"

download_clean:
	@rm -f $(tarballs) $(sha1s) $(patches)
