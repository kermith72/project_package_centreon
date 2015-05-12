##           Project Package Centreon

In order to install package Centreon-Engine

1. Install pre-requisites

apt-get install libcgsi-gsoap-dev zlib1g-dev libssl-dev libxerces-c-dev -y

2 Unzip files

tar xzf centreon-engine-1.4.11.tar.gz

3 copy files from github

centreon-engine-1.4.11/script/deb/postinst.in

centreon-engine-1.4.11/buid/CMakeLists

4 configure

```
cmake  \
    -DWITH_CENTREON_CLIB_INCLUDE_DIR=/usr/include  \
    -DWITH_CENTREON_CLIB_LIBRARY_DIR=/usr/lib  \
    -DWITH_PREFIX=/usr  \
    -DWITH_PREFIX_BIN=/usr/sbin  \
    -DWITH_PREFIX_CONF=/etc/centreon-engine  \
    -DWITH_USER=centreon-engine  \
    -DWITH_GROUP=centreon-engine  \
    -DWITH_LOGROTATE_SCRIPT=1 \
    -DWITH_VAR_DIR=/var/log/centreon-engine  \
    -DWITH_RW_DIR=/var/lib/centreon-engine/rw  \
    -DWITH_STARTUP_DIR=/etc/init.d  \
    -DWITH_PKGCONFIG_SCRIPT=1 \
    -DWITH_PKGCONFIG_DIR=/usr/lib/pkgconfig  \
    -DWITH_TESTING=0  \
    -DWITH_WEBSERVICE=1 .
```

5 create package

make package

make package_source

cpack -G DEB


