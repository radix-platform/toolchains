#
# Project Home:
# ============
# git.radix.pro/sources.git
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../../build-system/config.mk


url         = $(DOWNLOAD_SERVER)/sources/Linux/imx6

versions    = imx_3.0.35_4.1.0-20140124

description = linux-imx6.txt
tarballs    = $(addsuffix .tar.bz2, $(addprefix linux-, $(versions)))
defconfigs  = $(subst .tar.bz2,.defconfig, $(tarballs))
sha1s       = $(addsuffix .sha1sum, $(tarballs))


BUILD_TARGETS = $(description) $(tarballs) $(defconfigs) $(sha1s)


include ../../../build-system/core.mk


.PHONY: downloads_clean


$(description):
	@echo -e "\n======= Downloading $(description) file =======" ; \
	 echo "$(url)/$(description)" | xargs -n 1 -P 100 wget $(WGET_OPTIONS) -i & wait %1

$(tarballs):
	@echo -e "\n======= Downloading source tarballs =======" ; \
	 for tarball in $(tarballs) ; do \
	   echo "$(url)/$$tarball" | xargs -n 1 -P 100 wget $(WGET_OPTIONS) -i & \
	 done ; wait

$(defconfigs): $(tarballs)
	@echo -e "\n======= Downloading default config files =======" ; \
	 for defconfig in $(defconfigs) ; do \
	  echo "$(url)/$$defconfig" | xargs -n 1 -P 100 wget $(WGET_OPTIONS) -i & \
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

downloads_clean:
	@rm -f $(description) $(tarballs) $(defconfigs) $(sha1s)
