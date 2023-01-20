#!/bin/sh

set -ex

docker build . -t carma_cmake_builder
docker build . -f arm/Dockerfile -t carma_cmake_builder_arm