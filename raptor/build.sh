#!/bin/bash

set -x -e

INCLUDE_PATH="-I${PREFIX}/include"
LIBRARY_PATH="-L${PREFIX}/lib"

if [ "$(uname)" == "Darwin" ]; then
  MACOSX_VERSION_MIN=10.9
  CXXFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN}"
  CXXFLAGS="${CXXFLAGS} -stdlib=libc++ -std=c++11"
  LINKFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN}"
  LINKFLAGS="${LINKFLAGS} -stdlib=libc++ -L${LIBRARY_PATH}"
  CXX=llvm-g++
  CC=llvm-gcc
  export LIBTOOLIZE=/opt/local/bin/glibtoolize
fi
if [ "$(uname)" == "Linux" ]; then
  CXX=g++
  CC=gcc
fi

ln -s ${PREFIX}/lib ${PREFIX}/lib64

./autogen.sh --disable-gtk-doc --prefix=$PREFIX
make \
  | tee conda.make.log 2>&1
make install \
  | tee conda.make-install.log 2>&1
unlink ${PREFIX}/lib64
