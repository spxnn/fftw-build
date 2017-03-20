#!/bin/sh

# build i386 / x86_64 lib of fftw3 for macos

INSTALL_DIR=macos-install
mkdir -p $INSTALL_DIR

XCODE_TOOLCHAINS=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain
SDKROOT_OSX=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

# ---------------------------------------------------
#    i386
# ---------------------------------------------------
export CC="$XCODE_TOOLCHAINS/usr/bin/clang -x c -arch i386 -std=gnu99"
export CFLAGS="$CPPFLAGS -arch i386 -no-cpp-precomp -mmacosx-version-min=10.7 -isysroot $SDKROOT_OSX"
export CPPFLAGS="-I$SDKROOT_OSX/usr/include/"
export LD="$XCODE_TOOLCHAINS/usr/bin/ld"

./configure --enable-float
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
export CC="$XCODE_TOOLCHAINS/usr/bin/clang -x c -arch x86_64 -std=gnu99"
export CFLAGS="$CPPFLAGS -arch x86_64 -no-cpp-precomp -mmacosx-version-min=10.7 -isysroot $SDKROOT_OSX"
export CPPFLAGS="-I$SDKROOT_OSX/usr/include/"
export LD="$XCODE_TOOLCHAINS/usr/bin/ld"

./configure --enable-float
if [ $? -ne 0 ]; then
    echo "configure for x86_64 failed"
    exit
fi

make -j2

cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_x86_64.a
make distclean

# ---------------------------------------------------
#    lipo
# ---------------------------------------------------
lipo -arch i386 $INSTALL_DIR/libfftw3f_i386.a -arch x86_64 $INSTALL_DIR/libfftw3f_x86_64.a -create -output $INSTALL_DIR/libfftw3f.a

