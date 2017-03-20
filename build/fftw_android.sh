#!/bin/sh

# build arm lib of fftw3 for android

ANDROID_NDK=/opt/androidbuild/ndk/android-ndk-r9b
INSTALL_DIR=android-install

export PATH="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/darwin-x86_64/bin/:$PATH"
export SYS_ROOT="$ANDROID_NDK/platforms/android-9/arch-arm/"
export CC="arm-linux-androideabi-gcc --sysroot=$SYS_ROOT -mfloat-abi=softfp -mfpu=neon"
export LD="arm-linux-androideabi-ld"
export AR="arm-linux-androideabi-ar"
export RANLIB="arm-linux-androideabi-ranlib"
export STRIP="arm-linux-androideabi-strip"

mkdir -p $INSTALL_DIR
./configure --host=arm-eabi --prefix=$INSTALL_DIR --enable-float --enable-neon

make
make install

exit 0
