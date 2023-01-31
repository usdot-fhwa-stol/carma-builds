if(GENERATE_COVERAGE)

find_program( GCOVR_PATH gcovr )
if(NOT GCOVR_PATH)
    message(FATAL_ERROR "gcovr not found! Aborting...")
endif() # NOT GCOVR_PATH

set(COVERAGE_COMPILER_FLAGS "--coverage" CACHE INTERNAL "")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${COVERAGE_COMPILER_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COVERAGE_COMPILER_FLAGS}")
set(COVERAGE_OUTPUT_FILE coverage_sonar.xml)

add_custom_target(
    generate_coverage ALL
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    COMMAND ${GCOVR_PATH} -v --sonarqube build/${COVERAGE_OUTPUT_FILE} -s --filter src 2> gcov_run_cmake.out
    DEPENDS run_unit_test
    )

endif() # GENERATE_COVERAGE
