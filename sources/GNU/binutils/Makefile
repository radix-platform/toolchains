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

versions    = 2.16.1a 2.20.1a 2.21.1a 2.22 2.23.2 2.24 2.25 2.25.1 2.26

tarballs    = $(addsuffix .tar.bz2, $(addprefix binutils-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/patches/binutils-2.16.1-AVR.patch
patches    += $(CURDIR)/patches/binutils-2.20.1-mips-opcodes.patch
patches    += $(CURDIR)/patches/binutils-2.20.1-x86_64-multilib.patch
patches    += $(CURDIR)/patches/binutils-2.21.1-x86_64-multilib.patch
patches    += $(CURDIR)/patches/binutils-2.22-x86_64-multilib.patch
patches    += $(CURDIR)/patches/binutils-2.23.2-x86_64-multilib.patch
patches    += $(CURDIR)/patches/binutils-2.24-x86_64-multilib.patch
patches    += $(CURDIR)/patches/binutils-2.25.1-export-demangle.patch
patches    += $(CURDIR)/patches/binutils-2.25.1-no-config-check.patch
patches    += $(CURDIR)/patches/binutils-2.26-Bsymbolic-PIE.patch
patches    += $(CURDIR)/patches/binutils-2.26-GOT-offset.patch
patches    += $(CURDIR)/patches/binutils-2.26-compile-warnings.patch
patches    += $(CURDIR)/patches/binutils-2.26-lto.patch
patches    += $(CURDIR)/patches/binutils-2.26-rh1312151.patch
patches    += $(CURDIR)/patches/binutils-2.26-export-demangle.patch
patches    += $(CURDIR)/patches/binutils-2.26-no-config-check.patch

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
	 ( cd create-2.16.1-AVR-patch             ; ./create.patch.sh ) ; \
	 ( cd create-2.20.1-mips-opcodes-patch    ; ./create.patch.sh ) ; \
	 ( cd create-2.20.1-x86_64-multilib-patch ; ./create.patch.sh ) ; \
	 ( cd create-2.21.1-x86_64-multilib-patch ; ./create.patch.sh ) ; \
	 ( cd create-2.22-x86_64-multilib-patch   ; ./create.patch.sh ) ; \
	 ( cd create-2.23.2-x86_64-multilib-patch ; ./create.patch.sh ) ; \
	 ( cd create-2.24-x86_64-multilib-patch   ; ./create.patch.sh ) ; \
	 ( cd create-2.25.1-export-demangle-patch ; ./create.patch.sh ) ; \
	 ( cd create-2.25.1-no-config-check-patch ; ./create.patch.sh ) ; \
	 ( cd create-2.26-Bsymbolic-PIE-patch     ; ./create.patch.sh ) ; \
	 ( cd create-2.26-GOT-offset-patch        ; ./create.patch.sh ) ; \
	 ( cd create-2.26-compile-warnings-patch  ; ./create.patch.sh ) ; \
	 ( cd create-2.26-lto-patch               ; ./create.patch.sh ) ; \
	 ( cd create-2.26-rh1312151-patch         ; ./create.patch.sh ) ; \
	 ( cd create-2.26-export-demangle-patch   ; ./create.patch.sh ) ; \
	 ( cd create-2.26-no-config-check-patch   ; ./create.patch.sh ) ; \
	 echo -e "\n"

download_clean:
	@rm -f $(tarballs) $(sha1s) $(patches)
