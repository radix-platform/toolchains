#
# WEB: http://cvs.uclinux.org/cgi-bin/cvsweb.cgi/
#
# see: http://cvs.uclinux.org/cvs_anon.html
# =========================================
#
# We allow anonymous (read-only) CVS access to everyone.
# The first command you need to run for anonymous CVS access is:
#
# # cvs -d:pserver:anonymous@cvs.uclinux.org:/var/cvs login
#
# CVS will prompt you for a password. Just press the Enter key.
# This step only needs to be done once, the first time you attempt
# to access CVS.
#
# Once the login is complete, you can then check out the source
# code by running the following command (all on one line):
#
# # cvs -z3 -d:pserver:anonymous@cvs.uclinux.org:/var/cvs co -P uClinux-2.0.x userland.old
#
# This will create a directory called uClinux and a directory
# called userland in the current directory. These directories
# contain the latest and greatest source code for the uClinux
# kernel and for a number of applications. Once you've checked
# out a copy of the source tree, you can update your source tree
# at any time so it is in sync with the latest and greatest
# by running the command:
#
# # cvs -z3 update -d -P
#
# original url: :pserver:anonymous@cvs.uclinux.org:/var/cvs
#

COMPONENT_TARGETS = $(TOOLCHAIN_NOARCH)


include ../../../build-system/config.mk


url         = $(DOWNLOAD_SERVER)/sources/uClinux/elf2flt

versions    = 1.6 1.64

tarballs    = $(addsuffix .tar.bz2, $(addprefix elf2flt-, $(versions)))
sha1s       = $(addsuffix .sha1sum, $(tarballs))

patches     = $(CURDIR)/patches/elf2flt-1.6-verbose.patch
patches    += $(CURDIR)/patches/elf2flt-1.64-arm.patch

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
	 ( cd create-1.6-verbose-patch ; ./create.patch.sh ) ; \
	 ( cd create-1.64-arm-patch    ; ./create.patch.sh ) ; \
	 echo -e "\n"

download_clean:
	@rm -f $(tarballs) $(sha1s) $(patches)
