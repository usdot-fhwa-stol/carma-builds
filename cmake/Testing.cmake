# enable testing if the test directory exists and this is not a cross compile
IF(NOT DEFINED ENV{BUILD_ARCHITECTURE} AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/test AND IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/test)
    enable_testing()
    find_package(GTest REQUIRED)
    # add add source files in the test directory
    file(GLOB_RECURSE TEST_SOURCES LIST_DIRECTORIES false test/*.h test/*.cpp)
    set(UNIT_TEST ${PROJECT_NAME}_test)
    add_executable(${UNIT_TEST}
        ${TEST_SOURCES}
    )
    target_link_libraries(${UNIT_TEST} PUBLIC 
        ${PROJECT_NAME}
        ${TEST_LINK_LIBRARIES}
        gtest)
    add_test(NAME ${UNIT_TEST} COMMAND ${UNIT_TEST})
    add_custom_target(
        run_unit_test ALL
        COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure
        DEPENDS ${UNIT_TEST}
        )
endif()
