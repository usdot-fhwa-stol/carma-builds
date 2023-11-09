#!/bin/bash
set -e
# shellcheck source=/dev/null
. /etc/lsb-release
echo "Distribution code name : ${DISTRIB_CODENAME}"
apt-get update
apt-get -y install 
DEPENDENCIES=(
        wget
        ca-certificates
        build-essential
        gdb
        git)
DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends --yes --quiet "${DEPENDENCIES[@]}"
# Installing CMake 
CMAKE_VERSION="3.27.7"
echo "Installing CMake ${CMAKE_VERSION}"
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.sh
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
chmod u+x cmake-${CMAKE_VERSION}-linux-x86_64.sh
./cmake-${CMAKE_VERSION}-linux-x86_64.sh --skip-license --include-subdir --prefix=/opt
rm cmake-${CMAKE_VERSION}-linux-x86_64.sh
rm cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz
echo "export PATH=/opt/cmake-${CMAKE_VERSION}-linux-x86_64/bin:$PATH" >> /root/.bashrc
# shellcheck source=/dev/null
export PATH=/opt/cmake-${CMAKE_VERSION}-linux-x86_64/bin:$PATH
echo "CMake installation complete"
# Installing Google Test
GTEST_VERSION="1.14.0"
echo "Installing Google Test ${GTEST_VERSION}" 
git clone https://github.com/google/googletest.git -b "v${GTEST_VERSION}"
cd googletest/
cmake -Bbuild 
cd build/
make
make install
echo "Google Test installation complete"
cd -