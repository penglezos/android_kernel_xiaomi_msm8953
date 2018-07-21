#!/bin/bash

export CROSS_COMPILE="/home/englezos/kernel/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export ARCH=arm64 && export SUBARCH=arm64

mkdir -p out
make O=out clean
make O=out mrproper
make O=out mido_defconfig
make O=out -j$(nproc --all)