###################################################################################################
#
#           Project Package Centreon

# configure

cmake \
       -DWITH_TESTING=0 \
       -DWITH_PREFIX=/usr  \
       -DWITH_SHARED_LIB=1 \
       -DWITH_STATIC_LIB=0 \
       -DWITH_PKGCONFIG_DIR=/usr/lib/pkgconfig .

# make package

make package
make package_source
cpack -G DEB
