cmake_minimum_required(VERSION 3.20)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)

project(Vulkan_Project VERSION 0.1.0 LANGUAGES CXX C)

find_package(Vulkan REQUIRED)
include(cmake/CompilerWarnings.cmake)

add_subdirectory(third_party)
add_library(project_options INTERFACE)
set_target_properties(project_options PROPERTIES
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

target_compile_features(project_options INTERFACE cxx_std_20)
set_project_warnings(project_options)

set(source_code 
src/main.cpp
#${CMAKE_CURRENT_SOURCE_DIR}/include/*.h
#${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp
#${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
)

add_executable(Vulkan_Project ${source_code})
target_link_libraries(Vulkan_Project INTERFACE project_options)
target_include_directories(Vulkan_Project PRIVATE source)
target_link_libraries(${PROJECT_NAME} PUBLIC
    volk
    stb
    ${ASTC_TARGET}
    imgui
    glm
    glslang
    vma
    glslang-default-resource-limits
    spdlog
    glfw
)