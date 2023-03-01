FROM ubuntu:jammy as base

ARG STOL_APT_REPOSITORY=http://s3.amazonaws.com/stol-apt-repository
ARG BUILD_ARCHITECTURE

ENV STOL_APT_REPOSITORY=$STOL_APT_REPOSITORY

# add the CARMA repository to the sources list
RUN echo "deb [trusted=yes] ${STOL_APT_REPOSITORY} develop main" > /etc/apt/sources.list.d/carma.list

COPY cmake /opt/carma/cmake
COPY scripts /opt/carma/scripts
ENV CARMA_OPT_DIR=/opt/carma

RUN apt-get update

FROM base AS x64-version

# add build tools including Google test and mock
RUN apt-get install -y cmake build-essential file libgtest-dev libgmock-dev gdb

FROM base AS cross-compile-version

ARG BUILD_ARCHITECTURE
ENV BUILD_ARCHITECTURE=$BUILD_ARCHITECTURE

RUN apt-get install -y lsb-release

RUN echo BUILD_ARCHITECTURE=$BUILD_ARCHITECTURE

# setup to be able to install :<architecture> packages
COPY cross/add_cross_architecture_ports.sh /
RUN /add_cross_architecture_ports.sh

RUN apt-get update && apt-get install -y cmake crossbuild-essential-${BUILD_ARCHITECTURE} file

COPY cross/cmake_${BUILD_ARCHITECTURE}.toolchain.ubuntu /opt/carma/cmake/

RUN dpkg --add-architecture ${BUILD_ARCHITECTURE}

# modify CPack Debian module to allow Debian packaging to work for arm
# if not done then it finds objcopy for host which does not work
# this allow allows for exludiung some of the core cross packages from dependencies
RUN cp /usr/share/cmake-3.22/Modules/Internal/CPack/CPackDeb.cmake /usr/share/cmake-3.22/Modules/Internal/CPack/CPackDeb.cmake.orig
COPY cross/CPackDeb.cmake cmake /usr/share/cmake-3.22/Modules/Internal/CPack/
