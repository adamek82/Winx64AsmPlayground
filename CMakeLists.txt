cmake_minimum_required(VERSION 3.14)
project(Winx64AsmPlayground
    LANGUAGES C ASM_MASM
)

# Source files
set(SRC
    src/main.c
    src/hello.asm
    src/dynamic.asm
)

add_executable(${PROJECT_NAME} ${SRC})

# MASM debug info
set_target_properties(${PROJECT_NAME} PROPERTIES
    VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    COMPILE_FLAGS "/Zi"
)

# Ensure console subsystem
target_link_options(${PROJECT_NAME} PRIVATE /SUBSYSTEM:CONSOLE)

# (Optional) Include directory for headers
target_include_directories(${PROJECT_NAME} PRIVATE "${CMAKE_SOURCE_DIR}/include")