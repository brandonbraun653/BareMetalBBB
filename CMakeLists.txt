cmake_minimum_required(VERSION 3.18.0)
project(BareMetalBBB C CXX ASM)


set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)


# ====================================================
# Perform very high level configuration
# ====================================================
include("lib/CommonTools/cmake/options/common.cmake")
add_subdirectory("${COMMON_TOOL_ROOT}/cmake/device/am335x" ${PROJECT_BINARY_DIR}/DeviceTarget)

# ====================================================
# Project Targets
# ====================================================
add_subdirectory(led_on)

# ====================================================
# Project Exports
# ====================================================
# Public include location
add_library(project_inc INTERFACE)
target_include_directories(project_inc INTERFACE "${PROJECT_ROOT}")
export(TARGETS project_inc FILE "${PROJECT_BINARY_DIR}/Project/project_inc.cmake")