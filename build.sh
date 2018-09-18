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
KERNEL_DIR=$PWD
REPACK_DIR=$KERNEL_DIR/zip
OUT=$KERNEL_DIR/out
ZIP_NAME="$VERSION"-"$DATE"
DTB="dtb"
VERSION="6.0"
DATE=`date +"%Y%m%d"`
export ARCH=arm64 && export SUBARCH=arm64
export CROSS_COMPILE="/home/englezos/kernel/aarch64-linux-android-4.9/bin/aarch64-linux-android-"

make_zip()
{
		cd $REPACK_DIR
		mkdir kernel
		mkdir treble
		mkdir nontreble
		cp $KERNEL_DIR/out/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-nontreble.dtb $REPACK_DIR/nontreble/
		cp $KERNEL_DIR/out/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-treble.dtb $REPACK_DIR/treble/
		cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz $REPACK_DIR/kernel/
		FINAL_ZIP="Englezos-${VERSION}-${DATE}.zip"
        zip -r9 "${FINAL_ZIP}" *
		cp *.zip $OUT
		rm *.zip
		rm -rf kernel
		rm -rf treble
		rm -rf nontreble
		cd $KERNEL_DIR
		rm out/arch/arm64/boot/Image.gz
		#rm arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-nontreble.dtb
		#rm arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-treble.dtb
}

rm -rf out
mkdir -p out
make O=out clean
make O=out mrproper
make O=out mido_defconfig
make O=out -j$(nproc --all)
make_zip

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."