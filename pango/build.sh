#!/bin/bash

ln -s $PREFIX/lib $PREFIX/lib64

export PKG_CONFIG_PATH="$PREFIX/share/pkgconfig:$PREFIX/lib/pkgconfig"
export ACLOCAL_FLAGS="-I$PREFIX/share/aclocal"

export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"

./configure --prefix=$PREFIX \
            --enable-introspection=yes \
            --with-xft \
            --with-cairo=$PREFIX 

make
make install

unlink $PREFIX/lib64
