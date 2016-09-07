#!/bin/bash

set -x -e

INCLUDE_PATH="-I${PREFIX}/include"
LIBRARY_PATH="-L${PREFIX}/lib"
if [ "$(uname)" == "Linux" ]; then
  ln -s ${PREFIX}/lib ${PREFIX}/lib64
  /bin/bash ./autogen.sh
  HOST=$(./config.guess)
  ./configure \
      --prefix="${PREFIX}" \
      --with-boost="${PREFIX}" \
      --disable-cairo \
      --enable-openmp \
      CC=${HOST}-gcc \
      CXX=${HOST}-g++ \
      LDFLAGS=${LIBRARY_PATH} \
      CPPFLAGS=${INCLUDE_PATH} \
      PKG_CONFIG_PATH="${PKG_CONFIG_PATH}" \
     | tee conda.configure.log 2>&1
  make -j$(nproc) \
     | tee conda.make.log 2>&1
  make install \
     | tee conda.make-install.log 2>&1
  unlink ${PREFIX}/lib64
fi
