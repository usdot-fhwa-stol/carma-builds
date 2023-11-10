#!/bin/bash
set -e
apt-get update
apt-get -y install 
DEPENDENCIES=(
        wget
        ca-certificates
        build-essential
        gdb
        git
        file)
DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends --yes --quiet "${DEPENDENCIES[@]}"
cd /tmp
# Installing CMake 
CMAKE_VERSION="3.27.7"
echo "Installing CMake ${CMAKE_VERSION}"
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.sh
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
chmod u+x cmake-${CMAKE_VERSION}-linux-x86_64.sh
./cmake-${CMAKE_VERSION}-linux-x86_64.sh --skip-license --exclude-subdir --prefix=/usr
rm cmake-${CMAKE_VERSION}-linux-x86_64.sh
rm cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
echo "CMake installation complete"
# Installing Google Test
GTEST_VERSION="1.14.0"
echo "Installing Google Test ${GTEST_VERSION}" 
git clone https://github.com/google/googletest.git -b "v${GTEST_VERSION}"
cd googletest/
cmake -Bbuild
cmake --build build
cmake --install build
echo "Google Test installation complete"
cd ..
rm -r googletest/
