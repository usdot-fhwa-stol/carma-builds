CARMA Builds  is a component of the CARMA ecosystem, which enables such a coordination among different transportation users. This component provides Docker images used to build other projects within CARMA.

# CI Status

This badge is for the default branch only.

[![Docker Build](https://github.com/usdot-fhwa-stol/carma-builds/actions/workflows/docker.yml/badge.svg)](https://github.com/usdot-fhwa-stol/carma-builds/actions/workflows/docker.yml)

## Features

The image built from this project can be used to build C++ libraries and executables for the CARMA ecosystem.  It provides the following features:

* Adding the CARMA apt repository to the list of sources
* Pre-installed packages for [cmake](https://cmake.org/) and [build-essential](https://packages.ubuntu.com/jammy/build-essential)
* Pre-installed packages for [Google Test and Mock](https://google.github.io/googletest/)
* Images for x64 and arm cross compile builds with arm using the strategy defined here: https://wiki.debian.org/Multiarch/HOWTO
* Set of CMake helper files for the following functions:
  * Common source directory layout support (include, src, test)
  * Common install path setup for /opt/carma
  * Installation
  * [CPM.cmake](https://github.com/cpm-cmake/CPM.cmake) a cross-platform CMake script that adds dependency management capabilities to CMake
    * Allows you to pull in and build CMake dependencies that have git repos.
    > [!IMPORTANT]\
    > **Depends on `git` which is now added to `carma-builds-x64` base image**
  * [CPack CMake Debian packaging](https://cmake.org/cmake/help/latest/cpack_gen/deb.html)
    * Include dependency information
    * Standardize package names with dashes instead of underscores (RE: https://wiki.debian.org/DebianPackageInformation#Debian_Package_Information)
    * Require use of shared object versions for shared libraries
    * Creates dbgsym package when built in debug mode
  * Google Test support and test run during build
  * Code coverage generation using gcovr
* [Dependencies install script](scripts/install_dependencies_script.sh) which can install dependent packages and search a CMake file for those dependencies.
* [Build script](scripts/build_script.sh) which does an out of source build and may be used in VS Code as the default build task.  It has the following compilation modes:
  * Release (default)
  * Debug
  * Code Coverage

## Access

To use the image you will need to login to the [GitHub Conatiner Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) and pull the image using these steps:
* Create a [GitHub Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with read access to packages.
* On the host you want to use the image on run ```docker login ghcr.io``` to authenticate to the GHCR.
* Provide your GitHub user name and the token as the password.
* You should now be able to run ```docker pull ghcr.io/usdot-fhwa-stol/carma-builds-x64```

### TODO

* Dependency management - dev vs non-dev, mapping - May be good?
* Shared License - cannot currently put copyright in a Debian package with CPack

These items are likely done in a [template repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository):
* CI badges in README
* Sonar
* Publish docs
* gitignore
* [resuable github workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
* stanardized formatting (spaces, tabs, etc.) - [.editorconfig](https://editorconfig.org/)
* Debugging in container using launch configuration

## Contact
Please click on the CARMA logo below to visit the Federal Highway Adminstration(FHWA) CARMA website.

[![CARMA Image](https://raw.githubusercontent.com/usdot-fhwa-stol/CARMAPlatform/develop/docs/image/CARMA_icon.png)](https://highways.dot.gov/research/research-programs/operations/CARMA)
