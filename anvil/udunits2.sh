#!/bin/bash

set -e
set -u
set -x

# Install UDUNITS in /opt/udunits using /var/tmp/build/udunits as the build
# directory.

CC=${CC:-gcc}

build_dir=${build_dir:-/var/tmp/build/udunits}
prefix=${LOCAL_LIB_DIR:-/opt/udunits}

mkdir -p ${build_dir}
cd ${build_dir}
version=2.2.28

# --no-check-certificate is needed on ancient Ubuntu because
# ca-certificates is old
wget -nc \
     https://artifacts.unidata.ucar.edu/repository/downloads-udunits/${version}/udunits-${version}.tar.gz
rm -rf udunits-${version}
tar xzf udunits-${version}.tar.gz

cd udunits-${version}

./configure CC="${CC}" --prefix=${prefix}

make -j 128 all
make install
