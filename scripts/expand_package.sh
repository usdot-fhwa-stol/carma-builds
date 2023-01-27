#!/bin/sh
# This explodes the generated package into a folder to view the contents

set -ex

OUTPUT_DIR=package_output

dpkg-deb -R build/_packages/*deb build/${OUTPUT_DIR}
find build/${OUTPUT_DIR}