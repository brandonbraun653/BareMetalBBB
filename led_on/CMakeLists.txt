# -----------------------------------------------------------------------------
# Test Suite: HLD GPIO
# -----------------------------------------------------------------------------
add_executable(led_on
  startup.s
)

target_include_directories(led_on PRIVATE "." )

target_link_libraries(led_on PRIVATE

  # Target Build Properties
  # prj_device_target
  # prj_build_target
)
target_include_directories(led_on PRIVATE ${PROJECT_ROOT})
target_link_options(led_on PRIVATE "-T${CMAKE_SOURCE_DIR}/led_on/ram.ld")

# add_custom_command(TARGET led_on POST_BUILD
#     COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:led_on> ${LAST_BUILT_VERSION_DIRECTORY}/test_image
# )

# Last known working configuration command:
# cmake -DTOOLCHAIN=arm-linux-gnueabihf -DCMAKE_BUILD_TYPE=Debug --configure ../