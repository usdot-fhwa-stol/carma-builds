#!/bin/sh
set -e
. /etc/lsb-release
echo "Distribution code name : ${DISTRIB_CODENAME}"
apt-get update
if [ "$DISTRIB_CODENAME" = "bionic" ];then 
    echo "Installing bionic build tools ..."
    DEPENDENCIES="build-essential \
        cmake \
        build-essential \
        googletest \
        google-mock \
        gdb"
else
    echo "Installing other linux distribution build tools ..."
    DEPENDENCIES="build-essential \
        cmake \
        libgtest-dev \
        libgmock-dev \
        gdb"
fi
apt-get install -y $DEPENDENCIES