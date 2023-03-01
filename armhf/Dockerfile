FROM ubuntu:jammy

ARG STOL_APT_REPOSITORY=http://s3.amazonaws.com/stol-apt-repository
ENV STOL_APT_REPOSITORY=$STOL_APT_REPOSITORY

# add the CARMA repository to the sources list
RUN echo "deb [trusted=yes] ${STOL_APT_REPOSITORY} develop main" > /etc/apt/sources.list.d/carma.list

RUN apt-get update && apt-get install -y lsb-release

# setup to be able to install :armhf packages
COPY armhf/add_armhf_ports.sh /
RUN /add_armhf_ports.sh
RUN apt-get update

RUN apt-get install -y cmake crossbuild-essential-armhf file
COPY armhf/cmake_armhf.toolchain.ubuntu /opt/carma/cmake/

RUN dpkg --add-architecture armhf
ENV BUILD_ARCHITECTURE=armhf

COPY cmake /opt/carma/cmake
# modify CPack Debian module to allow Debian packaging to work for arm
# if not done then it finds objcopy for host which does not work
# this allow allows for exludiung some of the core cross packages from dependencies
RUN cp /usr/share/cmake-3.22/Modules/Internal/CPack/CPackDeb.cmake /usr/share/cmake-3.22/Modules/Internal/CPack/CPackDeb.cmake.orig
COPY armhf/CPackDeb.cmake cmake /usr/share/cmake-3.22/Modules/Internal/CPack/

COPY scripts /opt/carma/scripts
ENV CARMA_OPT_DIR=/opt/carma
