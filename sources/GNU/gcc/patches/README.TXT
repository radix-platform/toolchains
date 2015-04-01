
/* begin *

   NOTE that the 'at91sam7s-newlib' patches are not compatible with 'dm644x-newlib' patches and
   shouldn't be applied at the same time.

   gcc-4.5.1-at91sam7s-newlib.patch  -
   gcc-4.7.2-at91sam7s-newlib.patch  -
   gcc-4.7.3-at91sam7s-newlib.patch  -
   gcc-4.8.2-at91sam7s-newlib.patch  -
   gcc-4.9.1-at91sam7s-newlib.patch  -
   gcc-4.9.2-at91sam7s-newlib.patch  -

   gcc-4.5.1-dm644x-newlib.patch     -
   gcc-4.7.2-dm644x-newlib.patch     -
   gcc-4.7.3-dm644x-newlib.patch     -
   gcc-4.8.2-dm644x-newlib.patch     -
   gcc-4.9.1-dm644x-newlib.patch     -
   gcc-4.9.2-dm644x-newlib.patch     -

   gcc-4.5.1-mips-dspr2.patch        - doesn't need for 4.7.2 version.

   gcc-4.7.2-lpc17xx-multilib.patch  - adds --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m configure switch.
   gcc-4.7.3-lpc17xx-multilib.patch  - adds --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m configure switch.
   gcc-4.8.2-lpc17xx-multilib.patch  - adds --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m configure switch.
   gcc-4.9.1-lpc17xx-multilib.patch  - adds --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m configure switch.
   gcc-4.9.2-lpc17xx-multilib.patch  - adds --with-extra-multilibs=thumb1,thumb2,armv7-m,armv7e-m configure switch.

   gcc-4.9.2-bcm74x-libgo.patch      - This patch related to mips. During compilation with -Werror=maybe-unitialized
                                       option we have error with uninitialised 'enablegc' variable. This patch
                                       created just for building. We didn't check how it affect the target 'gccgo'
                                       compilator. Probably this misstake will be fixed in next releases of 'gccgo'.

   README.TXT                        - this file.

 * end */
