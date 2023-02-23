#!/bin/bash
# This script is provided as a helper for instaling dependencies during development

set -e

help()
{
    # Display Help
    echo "Standard script to install dependencies for STOL components"
    echo
    echo "Syntax: $0 [-c cmakeFile] pkg1 pkg2 ..."
    echo "options:"
    echo "c     Look in the passed in CMake file for CPACK_DEBIAN_PACKAGE_DEPENDS entried to include."
    echo "h     Print this Help."
    echo
}

# Get the options
while getopts "c:" option; do
    case $option in
        c) # generate coverage report
            CMAKE_SEARCH_FILE=${OPTARG}
            ;;
        h) # display Help
            help
            exit;;
    esac
done
shift $((OPTIND-1))

# don't start echoing output until now
set -x

if [ ! -z "$CMAKE_SEARCH_FILE" ]; then
    if [ ! -f $CMAKE_SEARCH_FILE ]; then
        echo "CMake file $CMAKE_SEARCH_FILE is not present!"
        exit 1
    fi
    # ref https://stackoverflow.com/questions/50897293/regex-extract-content-between-two-strings-using-sed-over-multiple-lines
    CMAKE_DEPENDENCIES=$(grep -zo "\\CPACK_DEBIAN_PACKAGE_DEPENDS[^)]*)" $CMAKE_SEARCH_FILE |  tr '\0\n' '\n ' | sed 's/CPACK_DEBIAN_PACKAGE_DEPENDS\(.*\))/\1/')
    echo "Found CMake dependencies: $CMAKE_DEPENDENCIES"
fi

PASSED_IN_DEPENDENCIES="$*"
echo "Passed in dependencies: $PASSED_IN_DEPENDENCIES"

if [ ! -z "${BUILD_ARCHITECTURE}" ]; then
    PACKAGE_ARCHITECTURE=":${BUILD_ARCHITECTURE}"
fi

PACKAGE_LIST_INITIAL="$CMAKE_DEPENDENCIES $PASSED_IN_DEPENDENCIES"
for nextPackage in ${PACKAGE_LIST_INITIAL}
do
    PACKAGE_LIST_FINAL="$PACKAGE_LIST_FINAL ${nextPackage}${PACKAGE_ARCHITECTURE}"
done

echo "Final package list: $PACKAGE_LIST_FINAL"
if [ -z "$PACKAGE_LIST_FINAL" ]; then
    echo "No dependencies found!"
    exit 1
fi

# ignore errors in apt-get as any issues will fall out in the install
apt-get update && true
apt-get install -y $PACKAGE_LIST_FINAL
