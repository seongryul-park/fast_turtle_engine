add_library(dependencies INTERFACE)

FetchContent_Declare(
        imgui
        GIT_REPOSITORY https://github.com/ocornut/imgui.git
        GIT_TAG docking
)
FetchContent_GetProperties(imgui)
if (NOT imgui_POPULATED)
    FetchContent_Populate(imgui)
    set(IMGUI_INCLUDE_DIR ${imgui_SOURCE_DIR} ${imgui_SOURCE_DIR}/backends)
    file(GLOB IMGUI_SOURCES ${imgui_SOURCE_DIR}/*.cpp)
    file(GLOB IMGUI_HEADERS ${imgui_SOURCE_DIR}/*.h)
    add_library(imgui STATIC 
        ${IMGUI_SOURCES}
        ${IMGUI_HEADERS}
        ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.h
        ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3_loader.h
        ${imgui_SOURCE_DIR}/backends/imgui_impl_sdl2.cpp ${imgui_SOURCE_DIR}/backends/imgui_impl_sdl2.h)
    target_include_directories(imgui PRIVATE ${IMGUI_INCLUDE_DIR} ${OPENGL_INCLUDE_DIR})
    target_link_libraries(imgui INTERFACE ${OPENGL_LIBRARIES})
endif ()

find_package(SDL2)
if (SDL2_FOUND)
    set(LINKER_NAME_SDL2 ${SDL2_LIBRARIES})
    set(INCLUDE_NAME_SDL2 ${SDL2_INCLUDE_DIRS})
    target_include_directories(imgui SYSTEM PRIVATE ${SDL2_INCLUDE_DIRS})
else()
    set(SDL2_DISABLE_SDL2MAIN ON)
    set(SDL2_DISABLE_INSTALL ON)
    set(SDL2_DISABLE_UNINSTALL ON)
    set(SDL_TEST_ENABLED_BY_DEFAULT OFF)
    set(SDL_SHARED_ENABLED_BY_DEFAULT OFF)
    set(SDL_STATIC_ENABLED_BY_DEFAULT ON)
    FetchContent_Declare(
        SDL2
        URL https://github.com/libsdl-org/SDL/releases/download/release-2.26.1/SDL2-2.26.1.tar.gz
        URL_HASH MD5=fba211fe2c67609df6fa3cf55d3c74dc
    )
    FetchContent_MakeAvailable(SDL2)
    set(LINKER_NAME_SDL2 SDL2-static)
    set(INCLUDE_NAME_SDL2 ${sdl2_SOURCE_DIR}/include)
    target_include_directories(imgui SYSTEM PRIVATE ${sdl2_SOURCE_DIR}/include)
endif()

set(GLEW_USE_STATIC_LIBS TRUE)
find_package(GLEW)
if (GLEW_FOUND)
    set(LINKER_NAME_GLEW GLEW::glew_s)
    set(INCLUDE_NAME_GLEW ${GLEW_INCLUDE_DIRS})
    target_include_directories(imgui SYSTEM PRIVATE ${GLEW_INCLUDE_DIRS})
else()
    set(BUILD_UTILS OFF)
    FetchContent_Declare(
        GLEW
        URL https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0.tgz
        URL_HASH MD5=3579164bccaef09e36c0af7f4fd5c7c7
        SOURCE_SUBDIR  build/cmake
    )
    FetchContent_MakeAvailable(GLEW)
    set(LINKER_NAME_GLEW glew_s)
    set(INCLUDE_NAME_GLEW ${glew_SOURCE_DIR}/include)
    target_include_directories(imgui SYSTEM PRIVATE ${glew_SOURCE_DIR}/include)
endif()
target_compile_definitions(imgui INTERFACE GLEW_STATIC)

FetchContent_Declare(
    STB
    GIT_REPOSITORY https://github.com/nothings/stb.git
    GIT_TAG master
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
)
FetchContent_MakeAvailable(STB)

FetchContent_Declare(
    GSL
    URL https://github.com/microsoft/GSL/archive/refs/tags/v4.0.0.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
)
FetchContent_MakeAvailable(GSL)

FetchContent_Declare(
    GLM
    URL https://github.com/g-truc/glm/archive/refs/tags/0.9.9.8.tar.gz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
)
FetchContent_MakeAvailable(GLM)

FetchContent_Declare(
    ASSIMP
    GIT_REPOSITORY https://github.com/assimp/assimp.git
    GIT_TAG master
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
)
FetchContent_MakeAvailable(ASSIMP)

target_link_libraries(dependencies INTERFACE
    imgui
    OpenGL::GL
    ${LINKER_NAME_SDL2}
    ${LINKER_NAME_GLEW}
    assimp
)
target_include_directories(dependencies SYSTEM INTERFACE
    ${IMGUI_INCLUDE_DIR}
    ${INCLUDE_NAME_SDL2}
    ${INCLUDE_NAME_GLEW}
    ${stb_SOURCE_DIR}
    ${gsl_SOURCE_DIR}/include
    ${glm_SOURCE_DIR}
    ${assimp_SOURCE_DIR}/include
    ${assimp_BINARY_DIR}/include
)
target_compile_definitions(dependencies INTERFACE GLEW_STATIC)