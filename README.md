

Toolchains
==========

The default destination path for installation is defined by **TOOLCHAINS_BASE_PATH** variable
in the [build-system/config.mk](build-system/config.mk) file. The access permissions
should be given to developer by the superuser:

```Bash
$ sudo mkdir -p /opt/toolchain
$ sudo chown -R developer:developers /opt/toolchain
```

To build all toolchains we have to run following command in the *products* directory:

```Bash
$ cd products
$ make -j32 all
```

Additional information can be found in the [*doc/README*](doc/README) file.


Creators
--------

**Andrey V. Kosteltsev**

* <https://twitter.com/AKosteltsev>
* <https://www.facebook.com/andrey.kosteltsev>
* <https://vk.com/andrey.kosteltsev>


Copyright and license
---------------------

Code and documentation copyright 2009-2017 Andrey V. Kosteltsev.
Code and documentation released under [the MIT License](LICENSE).

