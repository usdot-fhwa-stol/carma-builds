# Adapted from https://github.com/retifrav/cmake-cpack-example

# these are cache variables, so they could be overwritten with -D,
if (CMAKE_BUILD_TYPE STREQUAL "Debug" OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    # name the package as a debug version
    set (CPACK_DEBIAN_DEBUGINFO_PACKAGE ON)
    # add the dev suffix to the package version when using a DEBUG build
    if (CMAKE_BUILD_TYPE STREQUAL "Debug" AND NOT PACKAGE_VERSION_SUFFIX)
        set (PACKAGE_VERSION_SUFFIX "dev")
    endif()
else()
    set (CPACK_STRIP_FILES)
endif()
# check the SO version
get_target_property(target_type ${PROJECT_NAME} TYPE)
if (target_type STREQUAL "SHARED_LIBRARY")
    get_target_property(so_version ${PROJECT_NAME} SOVERSION)
    if (NOT so_version)
        message( FATAL_ERROR "Target property SOVERSION must be defined for shared library packages." )
    endif()
    set (PACKAGE_VERSION ${so_version})
endif()

if (NOT PACKAGE_VERSION)
    message( FATAL_ERROR "PACKAGE_VERSION must be defined for packages." )
endif()

# translate any _ to dash for the package name
string(REPLACE "_" "-" deb_package_name ${PROJECT_NAME})

set(CPACK_PACKAGE_NAME ${deb_package_name}-${PACKAGE_VERSION}${PACKAGE_NAME_EXTENSION}
    CACHE STRING "The resulting package name"
)
# which is useful in case of packing only selected components instead of the whole thing
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${PROJECT_DESCRIPTION}
    CACHE STRING "Package description for the package metadata"
)
set(CPACK_PACKAGE_VENDOR "FHWA Saxton Laboratory")

set(CPACK_VERBATIM_VARIABLES YES)

set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
SET(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/_packages")

# https://unix.stackexchange.com/a/11552/254512
set(CPACK_PACKAGING_INSTALL_PREFIX $ENV{CARMA_OPT_DIR})

set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
if (PACKAGE_VERSION_SUFFIX)
    # add a suffix if one is defined
    set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}-${PACKAGE_VERSION_SUFFIX}")
endif()

set(CPACK_PACKAGE_CONTACT "CARMAsupport@dot.gov")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "FHWA Saxton Laboratory <${CPACK_PACKAGE_CONTACT}>")

# license file not currently used in Debian packaging
#set(CPACK_RESOURCE_FILE_LICENSE "$ENV{CARMA_OPT_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

# package name for deb. If set, then instead of some-application-0.9.2-Linux.deb
# you'll get some-application_0.9.2_amd64.deb (note the underscores too)
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
# that is if you want every group to have its own package,
# although the same will happen if this is not set (so it defaults to ONE_PER_GROUP)
# and CPACK_DEB_COMPONENT_INSTALL is set to YES
set(CPACK_COMPONENTS_GROUPING ALL_COMPONENTS_IN_ONE)#ONE_PER_GROUP)
# without this you won't be able to pack only specified component
set(CPACK_DEB_COMPONENT_INSTALL YES)

# autogenerate dependency information
set (CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
# generate the shlibs control file
set (CPACK_DEBIAN_PACKAGE_GENERATE_SHLIBS ON)

# check to see if cross compile is happening
if (DEFINED ENV{BUILD_ARCHITECTURE})
    set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE $ENV{BUILD_ARCHITECTURE})
endif()

include(CPack)