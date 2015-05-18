In order to install package Centreon-clib

1 Install pre-requisites

apt-get install build-essential cmake -y

2 Unzip files

tar xzf centreon-clib-1.4.2.tar.gz

3 copy files from github


centreon-clib-1.4.2/build/package.cmake

4 configure

```
cmake  \
       -DWITH_TESTING=0 \
       -DWITH_PREFIX=/usr  \
       -DWITH_SHARED_LIB=1 \
       -DWITH_STATIC_LIB=0 \
       -DWITH_PACKAGE_DEB=1 \
       -DWITH_PKGCONFIG_DIR=/usr/lib/pkgconfig .
```

5 create package

make package

and package source

make package_source


