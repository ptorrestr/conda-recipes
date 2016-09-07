#!/bin/bash

set -x -e

INCLUDE_PATH="${PREFIX}/include"
LIBRARY_PATH="${PREFIX}/lib"

if [ "$(uname)" == "Linux" ]; then
  ./configure \
      --prefix="${PREFIX}" \
      CC=${PREFIX}/bin/gcc \
      LD=${PREFIX}/bin/gcc \
      CXX=${PREFIX}/bin/g++ \
      ARCHFLAGS="-arch x86_64" \
      CPPFLAGS="${CPPFLAGS}" \
      CXXFLAGS="${CXXFLAGS}" \
      PKG_CONFIG_PATH="${PKG_CONFIG_PATH}" \
     | tee conda.configure.log 2>&1
  make \
     | tee conda.make.log 2>&1
  make install \
     | tee conda.make-install.log 2>&1
fi
