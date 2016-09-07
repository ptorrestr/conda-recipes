#!/bin/bash 

set -x -e

INCLUDE_PATH="${PREFIX}/include"
LIBRARY_PATH="${PREFIX}/lib"

if [ "$(uname)" == "Linux" ]; then
  cmake  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_C_COMPILER="${PREFIX}/bin/gcc" \
    -DCMAKE_CXX_COMPILER="${PREFIX}/bin/g++" \
    -DGMP_LIBRARIES="-L${PREFIX}/lib -lgmp" \
    -DCGAL_CXX_FLAGS="-I${PREFIX}/include" \
    -DCGAL_MODULE_LINKER_FLAGS="-L${PREFIX}/lib" \
    -DCGAL_SHARED_LINKER_FLAGS="-L${PREFIX}/lib" \
    -DWITH_CGAL_Qt3=OFF \
    -DWITH_CGAL_Qt4=OFF \
    -DWITH_CGAL_Qt5=OFF \
    -DWITH_CGAL_ImageIO=OFF \
    -DGMP_INCLUDE_DIR="${PREFIX}/include" . \
    | tee conda.configure.log 2>&1
  make \
    | tee conda.make.log 2>&1
  make install \
    | tee conda.make-install.log 2>&1
fi
