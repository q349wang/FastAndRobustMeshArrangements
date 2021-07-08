cmake_minimum_required(VERSION 3.10)

# set the project name
project(fastmesharrange)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)


add_library(${PROJECT_NAME} solve_intersections.cpp solve_intersections.h
)

# Compiler-specific options
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
# grant IEEE 754 compliance
	target_compile_options(${PROJECT_NAME} PUBLIC -frounding-math)
	find_package(Threads)
	target_link_libraries(${PROJECT_NAME} ${CMAKE_THREAD_LIBS_INIT})
#	target_compile_options(${PROJECT_NAME} PUBLIC "/Oi")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
# grant IEEE 754 compliance
	target_compile_options(${PROJECT_NAME} PUBLIC "/fp:strict")
# use intrinsic functions
	target_compile_options(${PROJECT_NAME} PUBLIC "/Oi")
# turn off annoying warnings
	target_compile_options(${PROJECT_NAME} PUBLIC "/D _CRT_SECURE_NO_WARNINGS")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
# grant IEEE 754 compliance
	target_compile_options(${PROJECT_NAME} PUBLIC -O0)
endif()

# Public include directory
target_include_directories(${PROJECT_NAME} PUBLIC
	./
	code/
	external/Cinolib/external/eigen/
	external/Cinolib/include/
	external/IndirectPredicates/
	external/IndirectPredicates/predicates/
)

# preprocessor definitions
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
	target_compile_definitions(${PROJECT_NAME} PUBLIC -DIS64BITPLATFORM)
endif()

target_compile_definitions(${PROJECT_NAME} PUBLIC
	CINOLIB_USES_EXACT_PREDICATES
	DATA_PATH="./data/"
)

# Generate position independent code
set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)

# Export interface symbols and hide internal implementation
include(GenerateExportHeader)
generate_export_header(${PROJECT_NAME})
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_BINARY_DIR})
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_VISIBILITY_PRESET hidden)

