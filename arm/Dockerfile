FROM ubuntu:jammy

RUN apt-get update && apt-get install -y lsb-release

# setup to be able to install :armhf packages
COPY add_armhf_ports.sh /
RUN /add_armhf_ports.sh
RUN apt-get update

RUN apt-get install -y cmake crossbuild-essential-armhf file
COPY cmake_armhf.toolchain.ubuntu /usr/share/

RUN dpkg --add-architecture armhf
ENV BUILD_ARCHITECTURE=armhf
