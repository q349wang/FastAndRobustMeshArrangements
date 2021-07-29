cmake_minimum_required(VERSION 3.10)

# set the project name
project(fastmesharrange)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

file(GLOB SRC_FILES "code/*.cpp" )
file(GLOB CINO_FILES "external/Cinolib/include/cinolib/**/*.cpp" )

add_library(${PROJECT_NAME} INTERFACE
)
target_include_directories(${PROJECT_NAME} INTERFACE
	./
	code/
	external/Cinolib/external/eigen/
	external/Cinolib/include/
	external/IndirectPredicates/
	external/IndirectPredicates/predicates/
)

# Compiler-specific options
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
# grant IEEE 754 compliance
	target_compile_options(${PROJECT_NAME} INTERFACE -frounding-math)
	find_package(Threads)
	target_link_libraries(${PROJECT_NAME} INTERFACE ${CMAKE_THREAD_LIBS_INIT})
#	target_compile_options(${PROJECT_NAME} INTERFACE "/Oi")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
# grant IEEE 754 compliance
	target_compile_options(${PROJECT_NAME} INTERFACE "/fp:strict")
# use intrinsic functions
	target_compile_options(${PROJECT_NAME} INTERFACE "/Oi")
# turn off annoying warnings
	target_compile_options(${PROJECT_NAME} INTERFACE "/D _CRT_SECURE_NO_WARNINGS")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
# grant IEEE 754 compliance
	target_compile_options(${PROJECT_NAME} INTERFACE -O0)
endif()

# Public include directory


# preprocessor definitions
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
	target_compile_definitions(${PROJECT_NAME} INTERFACE -DIS64BITPLATFORM)
endif()

target_compile_definitions(${PROJECT_NAME} INTERFACE
	CINOLIB_USES_EXACT_PREDICATES
	DATA_PATH="./data/"
)

# Generate position independent code
#set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)

# Export interface symbols and hide internal implementation
#include(GenerateExportHeader)
#generate_export_header(${PROJECT_NAME})
#target_include_directories(${PROJECT_NAME} INTERFACE ${PROJECT_BINARY_DIR})
#set_target_properties(${PROJECT_NAME} PROPERTIES CXX_VISIBILITY_PRESET hidden)

