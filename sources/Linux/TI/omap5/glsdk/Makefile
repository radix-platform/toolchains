#
# Project Home:
# ============
# git.radix.pro/sources.git
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../../../../build-system/config.mk


url         = $(DOWNLOAD_SERVER)/sources/Linux/TI/omap5/glsdk

versions    = 3.8.13-20131223 3.8.13-20140222

tarballs    = $(addsuffix .tar.xz, $(addprefix linux-glsdk-, $(versions)))
defconfigs  = $(subst .tar.xz,.defconfig, $(tarballs))
sha1s       = $(addsuffix .sha1sum, $(tarballs))


BUILD_TARGETS = $(tarballs) $(defconfigs) $(sha1s)


include ../../../../../build-system/core.mk


.PHONY: download_clean


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

download_clean:
	@rm -f $(tarballs) $(defconfigs) $(sha1s)
