# -----------------------------------------------------------------------------
# Builds the led_on example
#
# Configure Command:
#   cmake -DTOOLCHAIN=arm-linux-gnueabihf -DCMAKE_BUILD_TYPE=Debug --configure ../
#
# Build Command:
#   cmake --build . --target led_on
# -----------------------------------------------------------------------------
include(${COMMON_TOOL_ROOT}/cmake/utility/embedded.cmake)

project(led_on)

#------------------------------------------------
# Main target to build the project
#------------------------------------------------
add_executable(${PROJECT_NAME}.elf startup.s)
target_link_options(${PROJECT_NAME}.elf PRIVATE "-T${CMAKE_SOURCE_DIR}/led_on/ram.ld")

# Create led_on.bin & led_on.lst
add_elf2bin_dependency(${PROJECT_NAME})
add_bin2lst_dependency(${PROJECT_NAME})

# High level target to build everything
add_custom_target(${PROJECT_NAME} DEPENDS ${PROJECT_NAME}.lst)