#!/bin/sh

# build fftw3 lib for macos

INSTALL_DIR=macos-install

set -e

mkdir -p $INSTALL_DIR
rm -rf $INSTALL_DIR/*

for arch in i386 x86_64; do
    export CC="gcc -arch ${arch}"

    ./configure --enable-float
    make -j4

    cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_${arch}.a
    make distclean
done

lipo -arch i386 $INSTALL_DIR/libfftw3f_i386.a -arch x86_64 $INSTALL_DIR/libfftw3f_x86_64.a -create -output $INSTALL_DIR/libfftw3f.a

