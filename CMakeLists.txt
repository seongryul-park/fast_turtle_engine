cmake_minimum_required(VERSION 3.20)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)

project(Stencil_cat VERSION 0.1.0 LANGUAGES CXX C)

include(FetchContent)
set(FETCHCONTENT_QUIET TRUE)
set(CMAKE_VERBOSE_MAKEFILE OFF)
if (CMAKE_VERSION VERSION_GREATER "3.24.0")
    # Avoid warnings in CMake 3.24.0:
    cmake_policy(SET CMP0135 NEW)
endif()

find_package(Vulkan REQUIRED)
include(cmake/CompilerWarnings.cmake)

add_library(project_options INTERFACE)
set_target_properties(project_options PROPERTIES
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

target_compile_features(project_options INTERFACE cxx_std_20)
set_project_warnings(project_options)

set(source_code main.cpp)

add_executable(Stencil_cat ${source_code})
target_link_libraries(Stencil_cat INTERFACE project_options)
target_include_directories(Stencil_cat PRIVATE source)
include(cmake/ExternalDependencies.cmake)
target_link_libraries(Stencil_cat PRIVATE dependencies)