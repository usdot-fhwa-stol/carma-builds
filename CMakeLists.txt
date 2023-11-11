cmake_minimum_required(VERSION 3.10)
project(carma_builds)

include(GNUInstallDirs)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/cmake/
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/carma_builds
  FILES_MATCHING
  PATTERN *.cmake
)

