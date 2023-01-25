# enable testing if the test directory exists and this is not a cross compile
IF(NOT DEFINED ENV{BUILD_ARCHITECTURE} AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/test AND IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/test)
    enable_testing()
    find_package(GTest REQUIRED)
    # add add source files in the test directory
    file(GLOB_RECURSE TEST_SOURCES LIST_DIRECTORIES false test/*.h test/*.cpp)
    add_executable(${PROJECT_NAME}_test 
        ${TEST_SOURCES}
    )
    target_link_libraries(${PROJECT_NAME}_test PUBLIC 
        ${PROJECT_NAME}
        ${TEST_LINK_LIBRARIES}
        gtest)
    add_test(NAME ${PROJECT_NAME}_test COMMAND ${PROJECT_NAME}_test)
endif()
