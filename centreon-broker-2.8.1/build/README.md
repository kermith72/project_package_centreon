##           Project Package Centreon

In order to install package Centreon-Broker

1 Install pre-requisites

apt-get install librrd-dev libqt4-dev libqt4-sql-mysql libgnutls-dev lsb-release -y

2 Unzip files

tar xzf centreon-broker-2.8.1.tar.gz

3 copy files from github


4 configure

```
cmake  \

```

5 create package

make package

make package_source

cpack -G DEB


