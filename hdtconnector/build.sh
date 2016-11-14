#!/bin/bash

set -x -e

if [ "$(uname)" == "Linux" ]; then
  ln -s ${PREFIX}/lib ${PREFIX}/lib64
  ls ${PREFIX}/include
  HDT_CFLAGS=${PREFIX}/include \
    HDT_LIBS=${PREFIX}/lib \
    BOOST_ROOT=${PREFIX} \
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}" \
    python setup.py install
fi
