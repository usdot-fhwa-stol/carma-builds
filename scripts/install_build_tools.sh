#!/bin/sh
set -e
# shellcheck source=/dev/null
. /etc/lsb-release
echo "Distribution code name : ${DISTRIB_CODENAME}"
apt-get update
if [ "$DISTRIB_CODENAME" = "bionic" ];then 
    echo "Installing bionic build tools ..."
    DEPENDENCIES="build-essential \
        cmake \
        googletest \
        google-mock \
        gdb \
        git"
else
    echo "Installing other linux distribution (focal or jammy) build tools ..."
    DEPENDENCIES="build-essential \
        cmake \
        libgtest-dev \
        libgmock-dev \
        gdb \
        git"
fi
apt-get install -y ${DEPENDENCIES}