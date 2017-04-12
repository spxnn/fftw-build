#!/bin/sh

# build fftw3 lib for ios

XCODE_TOOLCHAINS=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain
IOS_SYSROOT=`xcrun --sdk iphoneos --show-sdk-path`
INSTALL_DIR=ios-install

set -e

mkdir -p $INSTALL_DIR
rm -rf $INSTALL_DIR/*


for arch in armv7 armv7s arm64; do
    export CC="$XCODE_TOOLCHAINS/usr/bin/cc -arch ${arch} -std=gnu99 -mfpu=neon"
    export CFLAGS="-O3 -arch ${arch} -mfpu=neon -miphoneos-version-min=8.0 -pipe -isysroot ${IOS_SYSROOT}"
    export CPPFLAGS="-I$IOS_SYSROOT/usr/include"
 
    ./configure --host=arm-apple-darwin --enable-float --enable-neon
    make -j4

    cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_${arch}.a
    make distclean
done

lipo -arch armv7 $INSTALL_DIR/libfftw3f_armv7.a -arch armv7s $INSTALL_DIR/libfftw3f_armv7s.a -arch arm64 $INSTALL_DIR/libfftw3f_arm64.a -create -output $INSTALL_DIR/libfftw3f.a

