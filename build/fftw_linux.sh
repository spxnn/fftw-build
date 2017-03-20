#!/bin/sh

# build i386 / x86_64 lib of fftw3 for linux

INSTALL_DIR=linux-install
mkdir -p $INSTALL_DIR

# ---------------------------------------------------
#    i386
# ---------------------------------------------------
./configure --enable-float --enable-sse --enable-sse2 --enable-openmp --enable-avx
if [ $? -ne 0 ]; then
    echo "configure for i386 failed"
    exit
fi

make -j2

cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_i386.a
make distclean

# ---------------------------------------------------
#    x86_64
# ---------------------------------------------------
./configure --enable-float --enable-sse --enable-sse2 --enable-openmp --enable-avx
if [ $? -ne 0 ]; then
    echo "configure for x86_64 failed"
    exit
fi

make -j2

cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_x86_64.a
make distclean

