#
# Project Home:
# ============
# git.radix.pro/sources.git
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)

url         = ftp://ftp.radix.pro/sources/Linux/sunxi

versions    = 3.0.52-r2 3.0.57-r2 3.0.76-r0 3.4.43-r0

description = linux-sunxi.txt
tarballs    = $(addsuffix .tar.bz2, $(addprefix linux-, $(versions)))
defconfigs  = $(subst .tar.bz2,.defconfig, $(tarballs))
sha1s       = $(addsuffix .sha1sum, $(tarballs))


BUILD_TARGETS = $(description) $(tarballs) $(defconfigs) $(sha1s)


include ../../../build-system/core.mk


.PHONY: downloads_clean


$(description):
	wget $(WGET_OPTIONS) -N $(url)/$(description)

$(tarballs):
	@echo -e "\n======= Downloading source tarballs ======="
	@for tarball in $(tarballs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$tarball ; \
	done

$(defconfigs):
	@echo -e "\n======= Downloading default config files ======="
	@for defconfig in $(defconfigs) ; do \
	  wget $(WGET_OPTIONS) -N $(url)/$$defconfig ; \
	done

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
	@rm -f $(description) $(tarballs) $(defconfigs) $(sha1s)
