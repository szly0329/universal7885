#!/bin/bash
#
# Cronos Build Script
# For Exynos7885
# Coded by BlackMesa/AnanJaser1211/Prashantp01 @2018
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software

# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Directory Contol
CR_DIR=$(pwd)
CR_TC=/home/prashantp01/aarch64-linux-android-4.9/bin/aarch64-linux-android-
CR_DTS=arch/arm64/boot/dts
CR_DTB=$CR_DIR/boot.img-dtb
# Kernel Variables
CR_VERSION=V1.0
CR_NAME=Quantum_pie
CR_JOBS=5
CR_ANDROID=p
CR_PLATFORM=9.0.0
CR_ARCH=arm64
CR_DATE=$(date +%Y%m%d)
# Init build
export CROSS_COMPILE=$CR_TC
export ANDROID_MAJOR_VERSION=$CR_ANDROID
export PLATFORM_VERSION=$CR_PLATFORM
export $CR_ARCH
##########################################
# Device specific Variables [SM-A530F]
CR_CONFG_A530F=exynos7885-jackpotlte_defconfig
CR_VARIANT_A530F=A530F
# Device specific Variables [SM-A730F]
CR_CONFG_A730F=exynos7885-jackpot2lte_defconfig
CR_VARIANT_A730F=A730F
# Device specific Variables [SM-A530W]
CR_CONFG_A530W=exynos7885-jackpotltecan_defconfig
CR_VARIANT_A530W=A530W
##########################################

# Script functions
CLEAN_SOURCE()
{
echo "----------------------------------------------"
echo " "
echo "Cleaning"	
make clean
make mrproper
# rm -r -f $CR_OUT/*
rm -r -f $CR_DTB
rm -rf $CR_DTS/.*.tmp
rm -rf $CR_DTS/.*.cmd
rm -rf $CR_DTS/*.dtb 
echo " "
echo "----------------------------------------------"	
}
BUILD_ZIMAGE()
{
	echo "----------------------------------------------"
	echo " "
	echo "Building zImage for $CR_VARIANT"	
	export LOCALVERSION=-$CR_NAME-$CR_VERSION-$CR_VARIANT
	make  $CR_CONFG
	make -j$CR_JOBS
	echo " "
	echo "----------------------------------------------"	
}

# Main Menu
clear
echo "----------------------------------------------"
echo "$CR_NAME $CR_VERSION Build Script"
echo "----------------------------------------------"
PS3='Please select your option : '
menuvar=("SM-A530F" "SM-A530W" "SM-A730F" "Exit")
select menuvar in "${menuvar[@]}"
do
    case $menuvar in
        "SM-A530F")
            clear
            CLEAN_SOURCE
            echo "Starting $CR_VARIANT_A530F kernel build..."
	    CR_VARIANT=$CR_VARIANT_A530F
	    CR_CONFG=$CR_CONFG_A530F
	    BUILD_ZIMAGE
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
	    echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "SM-A730F")
            clear
            CLEAN_SOURCE
            echo "Starting $CR_VARIANT_A730F kernel build..."
	    CR_VARIANT=$CR_VARIANT_A730F
	    CR_CONFG=$CR_CONFG_A730F
	    BUILD_ZIMAGE
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
	    echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "SM-A530W")
            clear
            CLEAN_SOURCE
            echo "Starting $CR_VARIANT_A530W kernel build..."
	    CR_VARIANT=$CR_VARIANT_A530W
	    CR_CONFG=$CR_CONFG_A530W
	    BUILD_ZIMAGE
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
	    echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "Exit")
            break
            ;;
        *) echo Invalid option.;;
    esac
done

