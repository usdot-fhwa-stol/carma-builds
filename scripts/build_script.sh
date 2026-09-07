#!/bin/bash
# This script is provided as a helper for common build functions

set -e

help()
{
    # Display Help
    echo "Standard script to build STOL components"
    echo
    echo "Syntax: $0 [-c|d|h|p|s SUFFIX]"
    echo "options:"
    echo "c     Generate code coverage report with gcov."
    echo "d     Generate a debug build, default is release."
    echo "h     Print this Help."
    echo "p     Generate a Debian package using CPack."
    echo "s     Suffix to append to version for Debian packaging."
    echo "D     Pass CMake options to build command (e.i -DBUILD_TESTS=ON)"
    echo
}

BUILD_TYPE=Release
GENERATE_COVERAGE=0
GENERATE_DEBIAN_PACKAGE=0

# Get the options
while getopts "cdhps:D:" option; do
    case $option in
        c) # generate coverage report
            GENERATE_COVERAGE=1
            ;;
        d) # debug build
            BUILD_TYPE=Debug
            ;;
        p) # Debian package
            GENERATE_DEBIAN_PACKAGE=1
            ;;
        s) # Debian package version suffix
            PACKAGE_VERSION_SUFFIX="-DPACKAGE_VERSION_SUFFIX=${OPTARG}"
            ;;
        D) # Pass CMake options
            CMAKE_OPTIONS+=("-D$OPTARG")
            ;;
        h) # display Help
            help
            exit;;
    esac
done
shift $((OPTIND-1))

# don't start echoing output until now
set -x

# check to see if we need to use a toolchain for this build
if [ ! -z "${BUILD_ARCHITECTURE}" ]; then
    TOOLCHAIN_ARG="-DCMAKE_TOOLCHAIN_FILE=${CARMA_OPT_DIR}/cmake/cmake_${BUILD_ARCHITECTURE}.toolchain.ubuntu"
fi

BUILD_DIR=build${BUILD_ARCHITECTURE}
if [ $GENERATE_COVERAGE -eq 1 ]; then
    BUILD_TYPE=Debug
    COVERAGE_FLAGS=-DGENERATE_COVERAGE=True
fi

if [ $GENERATE_DEBIAN_PACKAGE -eq 1 ]; then
    cmake -B"${BUILD_DIR}" "${TOOLCHAIN_ARG}" -DCMAKE_CXX_FLAGS="${CXXFLAGS}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCREATE_DEB_PACKAGE=ON "${PACKAGE_VERSION_SUFFIX}"  "${COVERAGE_FLAGS}" "${CMAKE_OPTIONS[@]}"
    cd "${BUILD_DIR}"
    cmake --build .
    cpack -G DEB
else
    cmake -B"${BUILD_DIR}" "${TOOLCHAIN_ARG}" -DCMAKE_CXX_FLAGS="${CXXFLAGS}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" "${PACKAGE_VERSION_SUFFIX}"  "${COVERAGE_FLAGS}" "${CMAKE_OPTIONS[@]}"
    cd "${BUILD_DIR}"
    cmake --build .
    cpack -G DEB
fi

