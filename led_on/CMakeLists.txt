# -----------------------------------------------------------------------------
# Builds the led_on example
#
# Configure Command:
#   cmake -DTOOLCHAIN=arm-linux-gnueabihf -DCMAKE_BUILD_TYPE=Debug --configure ../
#
# Build Command:
#   cmake --build . --target led_on
# -----------------------------------------------------------------------------
project(led_on)


add_executable(${PROJECT_NAME}.elf startup.s)
target_link_options(${PROJECT_NAME}.elf PRIVATE "-T${CMAKE_SOURCE_DIR}/led_on/ram.ld")

add_custom_target(${PROJECT_NAME}.bin DEPENDS ${PROJECT_NAME}.elf)
add_custom_command(TARGET ${PROJECT_NAME}.bin
  COMMAND ${CMAKE_OBJCOPY} ARGS -O binary ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.elf ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.bin)

add_custom_target(${PROJECT_NAME}.lst DEPENDS ${PROJECT_NAME}.bin)
add_custom_command(TARGET ${PROJECT_NAME}.lst
  COMMAND ${CMAKE_OBJDUMP} ARGS -D -b binary -marm ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.bin > ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PROJECT_NAME}.lst)

add_custom_target(${PROJECT_NAME} DEPENDS ${PROJECT_NAME}.lst)