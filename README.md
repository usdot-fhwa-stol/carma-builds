CARMA Builds  is a component of CARMA ecosystem, which enables such a coordination among different transportation users. This component provides Docker images used to build other projects within CARMA.

## Features

The image built from this project can be used to build C++ libraries and executables for the CARMA ecosystem.  It provides the following features:

* Adding the CARMA apt repository to the list of sources
* Pre-installed packages for cmake and build-essential
* Pre-installed packages for Google Test and Mock
* Set of CMake helper files for the following functions:
  * Installation
  * Debian packaging
  * Google Test support

### TODO

* Dependency management - dev vs non-dev, mapping
* Get exact version versus latest
* Share other build scripts
* Shared License - cannot currently put copyright in a Debian package with CPack
* Sonar
* GCov
* Publish docs
* Run tests
* gitignore
* stanardized formatting (spaces, tabs, etc.) - .editorconfig
* debug packages
* resuable github workflows

## Contact
Please click on the CARMA logo below to visit the Federal Highway Adminstration(FHWA) CARMA website.

[![CARMA Image](https://raw.githubusercontent.com/usdot-fhwa-stol/CARMAPlatform/develop/docs/image/CARMA_icon.png)](https://highways.dot.gov/research/research-programs/operations/CARMA)
