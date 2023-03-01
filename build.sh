#!/bin/sh
# script used to build the x64 and arm cross compiler images in development environment

set -ex

DOCKER_BUILDKIT=1 docker build . --target x64-version -t carma_cmake_builder_x64

for arch in armhf arm64; do
    DOCKER_BUILDKIT=1 docker build . --target cross-compile-version --build-arg BUILD_ARCHITECTURE=${arch} -t carma_cmake_builder_${arch}
done
