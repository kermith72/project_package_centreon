In order to install package Centreon-ssh-connector

1 Install pre-requisites

apt-get install  libssh2-1-dev libgcrypt11-dev -y

2 Unzip files

tar xzf centreon-connector-1.1.1.tar.gz

3 copy files from github


centreon-connector-1.1.1/ssh/build/CMakeLists.txt

4 configure

```
cmake  \
  -DWITH_PREFIX=/usr \
  -DWITH_PREFIX_BINARY=/usr/lib/centreon-connector  \
  -DWITH_CENTREON_CLIB_INCLUDE_DIR=/usr/include \
  -DWITH_TESTING=0 .
```

5 create package

make package

make package_source

cpack -G DEB

