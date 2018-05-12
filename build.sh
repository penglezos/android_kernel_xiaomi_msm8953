#!/bin/bash
#
# Copyright © 2018, "penglezos" <panagiotisegl@gmail.com>
# Android Kernel Compilation Script
#

echo -e "***********************************************"
echo    "         Compiling Englezos Kernel             "
echo -e "***********************************************"
LC_ALL=C date +%Y-%m-%d
date=`date +"%Y%m%d-%H%M"`
BUILD_START=$(date +"%s")
export ARCH=arm64
export SUBARCH=arm64

export CLANG_PATH=/home/englezos/kernel/clang/bin/
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export TCHAIN_PATH="/home/englezos/kernel/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export CROSS_COMPILE="${CCACHE} ${TCHAIN_PATH}"
export CLANG_TCHAIN="/home/englezos/kernel/clang/bin/"
export KBUILD_COMPILER_STRING="$(${CLANG_TCHAIN} --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')"
make clean O=out/
make mrproper O=out/
make CC=clang mido_defconfig O=out/
make CC=clang -j$(nproc --all) O=out/

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."