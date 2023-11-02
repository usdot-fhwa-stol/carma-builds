#!/bin/sh
set -e
. /etc/lsb-release
apt-get update
if [${DISTRIB_CODENAME} == "bionic "] 
then
DEPENDENCIES="build-essential \
    cmake \
    build-essentail \
    google-test \
    google-mock \
    gdb"
else
DEPENDENCIES="build-essential \
    cmake \
    libgtest-dev \
    libgmock-dev \
    gdb"
fi
apt-get install -y $DEPENDENCIES