CARMA Builds  is a component of CARMA ecosystem, which enables such a coordination among different transportation users. This component provides Docker images used to build other projects within CARMA.

## Features

The image built from this project can be used to build C++ libraries and executables for the CARMA ecosystem.  It provides the following features:

* Adding the CARMA apt repository to the list of sources
* Pre-installed packages for [cmake](https://cmake.org/) and [build-essential](https://packages.ubuntu.com/jammy/build-essential)
* Pre-installed packages for [Google Test and Mock](https://google.github.io/googletest/)
* Set of CMake helper files for the following functions:
  * Common source directory layout support (include, src, test)
  * Installation
  * [CPack CMake Debian packaging](https://cmake.org/cmake/help/latest/cpack_gen/deb.html)
  * Google Test support and test run during build
  * Code coverage generation using gcovr
* [Build script](scripts/build_script.sh) which can be used in VS Code as the build task.  It has the following compilation modes:
  * Release (default)
  * Debug
  * Code Coverage

### TODO

* Dependency management - dev vs non-dev, mapping
* Get exact version versus latest
* Shared License - cannot currently put copyright in a Debian package with CPack
* Sonar
* Publish docs
* gitignore
* stanardized formatting (spaces, tabs, etc.) - [.editorconfig](https://editorconfig.org/)
* debug packages
* [resuable github workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)

## Contact
Please click on the CARMA logo below to visit the Federal Highway Adminstration(FHWA) CARMA website.

[![CARMA Image](https://raw.githubusercontent.com/usdot-fhwa-stol/CARMAPlatform/develop/docs/image/CARMA_icon.png)](https://highways.dot.gov/research/research-programs/operations/CARMA)
