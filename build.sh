#!/bin/bash
CLIB_VER="1.4.2"
CONNECTOR_VER="1.1.1"
ENGINE_VER="1.4.11"
PLUGIN_VER="2.0.3"
BROKER_VER="2.8.1"
CENTREON_VER="2.5.4"
CLAPI_VER="1.7.1"
## Sources URL
BASE_URL="https://s3-eu-west-1.amazonaws.com/centreon-download/public"
CLIB_URL="${BASE_URL}/centreon-clib/centreon-clib-${CLIB_VER}.tar.gz"
CONNECTOR_URL="${BASE_URL}/centreon-connectors/centreon-connector-${CONNECTOR_VER}.tar.gz"
ENGINE_URL="${BASE_URL}/centreon-engine/centreon-engine-${ENGINE_VER}.tar.gz"
PLUGIN_URL="http://www.nagios-plugins.org/download/nagios-plugins-${PLUGIN_VER}.tar.gz"
BROKER_URL="${BASE_URL}/centreon-broker/centreon-broker-${BROKER_VER}.tar.gz"
CENTREON_URL="${BASE_URL}/centreon/centreon-${CENTREON_VER}.tar.gz"
CLAPI_URL="${BASE_URL}/Modules/CLAPI/centreon-clapi-${CLAPI_VER}.tar.gz"

BASE_DIR=`pwd`
if [[ ! -d archives ]]
  then
    mkdir archives
fi
cd archives
if [[ -d centreon-broker-${BROKER_VER} ]]
  then
    echo 'file already exist'
  else
    curl -0 ${BROKER_URL} | tar -zx
fi
if [[ -d centreon-clib-${CLIB_VER} ]]
  then
    echo 'file already exist'
  else
    curl -0 ${CLIB_URL} | tar -zx
fi
if [[ -d centreon-connector-${CONNECTOR_VER} ]]
  then
    echo 'file already exist'
  else
  curl -0 ${CONNECTOR_URL} | tar -xz
fi
if [[ -d centreon-engine-${ENGINE_VER} ]]
  then
    echo 'file already exist'
  else
    curl -0 ${ENGINE_URL} | tar -xz
fi

cd ${BASE_DIR}
PACKAGE="centreon-broker-${BROKER_VER}"

echo "Creating ${PACKAGE} deb package"
if [[ -e ${PACKAGE}.deb ]]
  then
    echo "${PACKAGE}.deb already exist"
    echo "Skiping compilation"
  else
    cd ${BASE_DIR}/archives/${PACKAGE}/build
    cp -r ${BASE_DIR}/${PACKAGE}/ ${BASE_DIR}/archives/
    cmake  \
       -DWITH_DAEMONS='central-broker;central-rrd' \
       -DWITH_GROUP=centreon-broker \
       -DWITH_PREFIX=/usr  \
       -DWITH_PREFIX_BIN=/usr/sbin  \
       -DWITH_PREFIX_CONF=/etc/centreon-broker  \
       -DWITH_PREFIX_LIB=/usr/lib/centreon-broker \
       -DWITH_PREFIX_MODULES=/usr/share/centreon/lib/centreon-broker \
       -DWITH_STARTUP_DIR=/etc/init.d \
       -DWITH_STARTUP_SCRIPT=auto \
       -DWITH_PACKAGE_DEB=1 \
       -DWITH_PACKAGE_TGZ=1 \
       -DWITH_PACKAGE_TBZ2=1 \
       -DWITH_TESTING=0 \
       -DWITH_USER=centreon-broker .
    make package
    make package_source
    cp ${PACKAGE}.deb ${BASE_DIR}
fi
dpkg -i ${PACKAGE}.deb

cd ${BASE_DIR}
PACKAGE="centreon-clib-${CLIB_VER}"

echo "Creating ${PACKAGE} deb package"
if [[ -e ${PACKAGE}.deb ]]
  then
    echo "${PACKAGE}.deb already exist"
  else
    cd ${BASE_DIR}/archives/${PACKAGE}/build
    cp -r ${BASE_DIR}/${PACKAGE} ${BASE_DIR}/archives/
    cmake  \
      -DWITH_TESTING=0 \
      -DWITH_PREFIX=/usr  \
      -DWITH_SHARED_LIB=1 \
      -DWITH_STATIC_LIB=0 \
      -DWITH_PACKAGE_DEB=1 \
      -DWITH_PKGCONFIG_DIR=/usr/lib/pkgconfig .
    make package
    make package_source
    cp ${PACKAGE}.deb ${BASE_DIR}
fi
dpkg -i ${PACKAGE}.deb

for TYPE in perl ssh
do
  cd ${BASE_DIR}
  PACKAGE="centreon-connector-${TYPE}-${CONNECTOR_VER}"

  echo "Creating ${PACKAGE} deb package"
  if [[ -e ${PACKAGE}.deb ]]
    then
      echo "${PACKAGE}.deb already exist"
    else
      cd ${BASE_DIR}/archives/centreon-connector-${CONNECTOR_VER}/${TYPE}/build
      cp -r ${BASE_DIR}/centreon-connector-${CONNECTOR_VER} ${BASE_DIR}/archives/
      cmake  \
        -DWITH_PREFIX=/usr \
        -DWITH_PREFIX_BINARY=/usr/lib/centreon-connector  \
        -DWITH_CENTREON_CLIB_INCLUDE_DIR=/usr/include \
        -DWITH_PACKAGE_DEB=1 \
        -DWITH_TESTING=0 .
      make package
      make package_source
      cp ${PACKAGE}.deb ${BASE_DIR}
  fi
  dpkg -i ${PACKAGE}.deb
done

cd ${BASE_DIR}
PACKAGE="centreon-engine-${ENGINE_VER}"

echo "Creating ${PACKAGE} deb package"
if [[ -e ${PACKAGE}.deb ]]
  then
    echo "${PACKAGE}.deb already exist"
  else
    cd ${BASE_DIR}/archives/${PACKAGE}/build
    cp -r ${BASE_DIR}/${PACKAGE} ${BASE_DIR}/archives/
    cmake  \
      -DWITH_TESTING=0 \
      -DWITH_PREFIX=/usr  \
      -DWITH_SHARED_LIB=1 \
      -DWITH_STATIC_LIB=0 \
      -DWITH_PACKAGE_DEB=1 \
      -DWITH_PKGCONFIG_DIR=/usr/lib/pkgconfig .
    make package
    make package_source
    cp ${PACKAGE}.deb ${BASE_DIR}
fi
