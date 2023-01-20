FROM ubuntu:jammy

# add the CARMA repository to the sources list
RUN echo "deb [trusted=yes] https://s3.amazonaws.com/${AWS_BUCKET_NAME} develop main" > /etc/apt/sources.list.d/carma.list

RUN apt-get update && apt-get install -y lsb-release

# setup to be able to install :armhf packages
COPY arm/add_armhf_ports.sh /
RUN /add_armhf_ports.sh
RUN apt-get update

RUN apt-get install -y cmake crossbuild-essential-armhf file
COPY arm/cmake_armhf.toolchain.ubuntu /opt/carma/cmake/

RUN dpkg --add-architecture armhf
ENV BUILD_ARCHITECTURE=armhf

COPY cmake /opt/carma/cmake
ENV CARMA_OPT_DIR=/opt/carma
