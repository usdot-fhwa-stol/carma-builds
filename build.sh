#!/bin/sh
# script used to build the x64 and arm cross compiler images in development environment

set -ex

for arch in x64 armhf; do
    docker build . -f ${arch}/Dockerfile -t carma_cmake_builder_${arch}
done
