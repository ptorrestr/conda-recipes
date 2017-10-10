#!/bin/bash

set -x -e

INCLUDE_PATH="-I${PREFIX}/include"
LIBRARY_PATH="-L${PREFIX}/lib"

if [ "$(uname)" == "Darwin" ]; then
  MACOSX_VERSION_MIN=10.11
  CXXFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN}"
  CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
  LINKFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN}"
  LINKFLAGS="${LINKFLAGS} -stdlib=libc++ ${LIBRARY_PATH}"
  ln -s ${PREFIX}/lib ${PREFIX}/lib64
  /bin/bash ./autogen.sh
  HOST=$(./build/config.guess)
  ./configure \
    --prefix="${PREFIX}" \
    LDFLAGS=${LIBRARY_PATH} \
    CPPFLAGS=${INCLUDE_PATH} \
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}" \
    |  tee conda.configure.log 2>&1
  make -j$(sysctl -n hw.ncpu) \
    | tee conda.make.log 2>&1
  make install \
    | tee conda.make-install.log 2>&1
  unlink ${PREFIX}/lib64
fi

if [ "$(uname)" == "Linux" ]; then
  ln -s ${PREFIX}/lib ${PREFIX}/lib64
  /bin/bash ./autogen.sh
  HOST=$(./build/config.guess)
  ./configure \
    --prefix="${PREFIX}" \
    LDFLAGS=${LIBRARY_PATH} \
    CPPFLAGS=${INCLUDE_PATH} \
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}" \
    |  tee conda.configure.log 2>&1
  make -j$(nproc) \
    | tee conda.make.log 2>&1
  make install \
    | tee conda.make-install.log 2>&1
  unlink ${PREFIX}/lib64
fi
