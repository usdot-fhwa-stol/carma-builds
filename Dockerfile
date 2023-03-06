FROM ubuntu:jammy as base

# copy the standard CMake scripts into the image
COPY cmake /opt/carma/cmake
COPY scripts /opt/carma/scripts
ENV CARMA_OPT_DIR=/opt/carma

# have the package manager scan the current repo list
RUN apt-get update

FROM base AS x64-version

# add build tools including Google test and mock
RUN apt-get install -y cmake build-essential file libgtest-dev libgmock-dev gdb

FROM base AS cross-compile-version

# set an envionrment variable anything can use to tell this is a cross compile environment
ARG BUILD_ARCHITECTURE
ENV BUILD_ARCHITECTURE=$BUILD_ARCHITECTURE

# add this to check what distribution we are in
RUN apt-get install -y lsb-release

# setup to be able to install :<architecture> packages for use in cross compiles
COPY cross/add_cross_architecture_ports.sh /
RUN /add_cross_architecture_ports.sh

# install the cross compiler
RUN apt-get update && apt-get install -y cmake crossbuild-essential-${BUILD_ARCHITECTURE} file

# copy in our CMake toolchain file which indicates which compile tools to use
COPY cross/cmake_${BUILD_ARCHITECTURE}.toolchain.ubuntu /opt/carma/cmake/

# tell the package manager that there is another architecture to use
RUN dpkg --add-architecture ${BUILD_ARCHITECTURE}

# modify CPack Debian module to allow Debian packaging to work for arm
# if not done then it finds objcopy for host which does not work
# this allow allows for exludiung some of the core cross packages from dependencies
RUN cp /usr/share/cmake-3.22/Modules/Internal/CPack/CPackDeb.cmake /usr/share/cmake-3.22/Modules/Internal/CPack/CPackDeb.cmake.orig
COPY cross/CPackDeb.cmake cmake /usr/share/cmake-3.22/Modules/Internal/CPack/
