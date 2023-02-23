#!/bin/sh
# script used to build the x64 and arm cross compiler images in development environment

set -ex

docker build . -t carma_cmake_builder
docker build . -f arm/Dockerfile -t carma_cmake_builder_arm