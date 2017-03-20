#!/bin/sh

# build arm lib of fftw3 for ios

INSTALL_DIR=ios-library
mkdir -p $INSTALL_DIR

XCODE_TOOLCHAINS=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain
SDKROOT_IOS=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS10.2.sdk

# ---------------------------------------------------
#    armv7
# ---------------------------------------------------
export CC="$XCODE_TOOLCHAINS/usr/bin/clang -x c -arch armv7 -std=gnu99 -mfpu=neon"
export CFLAGS="$CPPFLAGS -arch armv7 -mfpu=neon -no-cpp-precomp -miphoneos-version-min=7.1 -isysroot $SDKROOT_IOS"
export CPPFLAGS="-I$SDKROOT_IOS/usr/include/ -mfpu=neon"
export LD=$XCODE_TOOLCHAINS/usr/bin/ld

./configure --host=arm-apple-darwin --enable-float --enable-neon
if [ $? -ne 0 ]; then
    echo "configure for armv7 failed"
    exit
fi

make -j2

cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_armv7.a
make distclean

# ---------------------------------------------------
#    armv7s
# ---------------------------------------------------
export CC="$XCODE_TOOLCHAINS/usr/bin/clang -x c -arch armv7s -std=gnu99 -mfpu=neon"
export CFLAGS="$CPPFLAGS -arch armv7s -mfpu=neon -no-cpp-precomp -miphoneos-version-min=7.1 -isysroot $SDKROOT_IOS"
export CPPFLAGS="-I$SDKROOT_IOS/usr/include/ -mfpu=neon"
export LD=$XCODE_TOOLCHAINS/usr/bin/ld

./configure --host=arm-apple-darwin --enable-float --enable-neon
if [ $? -ne 0 ]; then
    echo "configure for armv7s failed"
    exit
fi

make -j2

cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_armv7s.a
make distclean

# ---------------------------------------------------
#    arm64
# ---------------------------------------------------
export CC="$XCODE_TOOLCHAINS/usr/bin/clang -x c -arch arm64 -std=gnu99 -mfpu=neon"
export CFLAGS="$CPPFLAGS -arch arm64 -mfpu=neon -no-cpp-precomp -miphoneos-version-min=7.1 -isysroot $SDKROOT_IOS"
export CPPFLAGS="-I$SDKROOT_IOS/usr/include/ -mfpu=neon"
export LD=$XCODE_TOOLCHAINS/usr/bin/ld

./configure --host=arm-apple-darwin --enable-float --enable-neon
if [ $? -ne 0 ]; then
    echo "configure for arm64 failed"
    exit
fi

make -j2

cp .libs/libfftw3f.a $INSTALL_DIR/libfftw3f_arm64.a
make distclean

# ---------------------------------------------------
#    lipo
# ---------------------------------------------------
lipo -arch armv7 $INSTALL_DIR/libfftw3f_armv7.a -arch armv7s $INSTALL_DIR/libfftw3f_armv7s.a -arch arm64 $INSTALL_DIR/libfftw3f_arm64.a -create -output $INSTALL_DIR/libfftw3f.a

