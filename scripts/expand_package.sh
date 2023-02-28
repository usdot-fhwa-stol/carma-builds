#!/bin/sh
# This explodes the generated package into a folder to view the contents

set -ex

OUTPUT_DIR=package_output
BUILD_DIR=build${BUILD_ARCHITECTURE}

dpkg-deb -R ${BUILD_DIR}/_packages/*deb ${BUILD_DIR}/${OUTPUT_DIR}
find ${BUILD_DIR}/${OUTPUT_DIR}