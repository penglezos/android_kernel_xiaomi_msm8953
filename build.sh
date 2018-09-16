#!/bin/bash
#
# Copyright © 2018, "penglezos" <panagiotisegl@gmail.com>
# Thanks to Vipul Jha for zip creator
# Android Kernel Compilation Script
#

tput reset
echo -e "==============================================="
echo    "         Compiling Englezos Kernel             "
echo -e "==============================================="

LC_ALL=C date +%Y-%m-%d
date=`date +"%Y%m%d-%H%M"`
BUILD_START=$(date +"%s")
export CROSS_COMPILE="/home/englezos/kernel/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export ARCH=arm64 && export SUBARCH=arm64

mkdir -p out
make O=out clean
make O=out mrproper
make O=out mido_defconfig
make O=out -j$(nproc --all)

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."