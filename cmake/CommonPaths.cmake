# these settings can be used to automatically find CARMA intalled packages
set(CMAKE_PREFIX_PATH $ENV{CARMA_OPT_DIR})
include_directories($ENV{CARMA_OPT_DIR}/include)
link_directories($ENV{CARMA_OPT_DIR}/lib)
