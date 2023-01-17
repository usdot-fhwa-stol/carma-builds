#!/bin/sh

docker build . -t carma_cmake_builder
docker build arm -t carma_cmake_builder_arm