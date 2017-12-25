# ****************************************************************************
#  Project:  LibCMaker_GoogleTest
#  Purpose:  A CMake build script for Google Test library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017 NikitaFeodonit
#
#    This file is part of the LibCMaker_GoogleTest project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************

cmake_minimum_required(VERSION 3.2 FATAL_ERROR)

project(LibCMaker_GoogleTest_Compile_Test CXX)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")


#-----------------------------------------------------------------------
# Configure for find_package.
#-----------------------------------------------------------------------

# Set CMake's search path for find_package(), find_program(), find_library(),
# find_file(), and find_path() commands.
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")

if(ANDROID)
  list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX}")
endif()


#-----------------------------------------------------------------------
# Set path to LibCMaker root
#-----------------------------------------------------------------------

set(LIBCMAKER_SRC_DIR "${PROJECT_SOURCE_DIR}/cmake/LibCMaker")
# Uncomment it if need functions from LibCMaker
#list(APPEND CMAKE_MODULE_PATH "${LIBCMAKER_SRC_DIR}/cmake/modules")


#-----------------------------------------------------------------------
# Set vars for LibCMaker_GoogleTest.
#-----------------------------------------------------------------------

# Standard CMake vars.
#set(BUILD_SHARED_LIBS ON)

#set(SKIP_INSTALL_HEADERS ON)
#set(SKIP_INSTALL_LIBRARIES ON)
#set(SKIP_INSTALL_ALL ON)

option(BUILD_TESTING "Build the testing tree." ON)

# Set useful vars for lib_cmaker_googletest().
set(cmr_PRINT_DEBUG ON)

set(GOOGLETEST_lib_VERSION "1.8.20171222")

set(GOOGLETEST_DOWNLOAD_DIR "${PROJECT_BINARY_DIR}")
set(GOOGLETEST_UNPACKED_SRC_DIR "${PROJECT_BINARY_DIR}")
set(GOOGLETEST_BUILD_DIR "${PROJECT_BINARY_DIR}/build_googletest")

# Library specific vars and options.
set(GTEST_ROOT "${CMAKE_INSTALL_PREFIX}")
set(ENV{GTEST_ROOT} "${GTEST_ROOT}")


#-----------------------------------------------------------------------
# Common Google Test and Google Mock options
#
option(BUILD_GTEST "Builds the googletest subproject" ON)
#Note that googlemock target already builds googletest
option(BUILD_GMOCK "Builds the googlemock subproject" OFF)

# BUILD_SHARED_LIBS is a standard CMake variable, but we declare it here to
# make it prominent in the GUI.
option(BUILD_SHARED_LIBS "Build shared libraries (DLLs)." OFF)

#-----------------------------------------------------------------------
# Google Test options
#

# When other libraries are using a shared version of runtime libraries,
# Google Test also has to use one.
option(
  gtest_force_shared_crt
  "Use shared (DLL) run-time lib even when Google Test is built as static lib."
  OFF
)
option(gtest_build_tests "Build all of gtest's own tests." OFF)
option(gtest_build_samples "Build gtest's sample programs." OFF)
option(gtest_disable_pthreads "Disable uses of pthreads in gtest." OFF)
option(
  gtest_hide_internal_symbols
  "Build gtest with internal symbols hidden in shared libraries."
  OFF
)

#-----------------------------------------------------------------------
# Google Mock options
#
option(gmock_build_tests "Build all of Google Mock's own tests." OFF)


#-----------------------------------------------------------------------
# Build and install the GoogleTest.
#-----------------------------------------------------------------------

include(
  ${PROJECT_SOURCE_DIR}/cmake/LibCMaker_GoogleTest/lib_cmaker_googletest.cmake)

# Make compile, build and install the library at a config CMake phase,
# generate the CMake config files.

# Install specified library version.
lib_cmaker_googletest(
  VERSION           ${GOOGLETEST_lib_VERSION}
  DOWNLOAD_DIR      ${GOOGLETEST_DOWNLOAD_DIR}
  UNPACKED_SRC_DIR  ${GOOGLETEST_UNPACKED_SRC_DIR}
  BUILD_DIR         ${GOOGLETEST_BUILD_DIR}
)


#-----------------------------------------------------------------------
# find_package
#-----------------------------------------------------------------------

set(LIBCMAKER_GOOGLETEST_SRC_DIR
  "${PROJECT_SOURCE_DIR}/cmake/LibCMaker_GoogleTest")
# To use our FindGTest.cmake
list(APPEND CMAKE_MODULE_PATH "${LIBCMAKER_GOOGLETEST_SRC_DIR}/cmake")

# Use newly got library.
find_package(GTest REQUIRED)


#-----------------------------------------------------------------------
# Link to the library.
#-----------------------------------------------------------------------

# Get an example sources from the Google Test sources.
include(
  ${PROJECT_SOURCE_DIR}/cmake/LibCMaker_GoogleTest/cmake/modules/cmr_googletest_get_download_params.cmake)
cmr_googletest_get_download_params(${GOOGLETEST_lib_VERSION}
  lib_URL lib_SHA lib_SRC_DIR_NAME lib_ARCH_FILE_NAME)
set(lib_SRC_DIR "${GOOGLETEST_UNPACKED_SRC_DIR}/${lib_SRC_DIR_NAME}")

# Build lib for testing.
add_library(${PROJECT_NAME}_lib
  ${lib_SRC_DIR}/googletest/samples/sample1.h
  ${lib_SRC_DIR}/googletest/samples/sample1.cc
)

# Testing with Google Test.
if(BUILD_TESTING)
  enable_testing()
  add_executable(${PROJECT_NAME}_unittest
    ${lib_SRC_DIR}/googletest/samples/sample1_unittest.cc
  )
  target_link_libraries(${PROJECT_NAME}_unittest
    ${PROJECT_NAME}_lib      # Our lib for testing.
    GTest::GTest GTest::Main # GTest libs.
  )
  add_test(NAME AllTestsIn_${PROJECT_NAME} COMMAND ${PROJECT_NAME}_unittest)
  
  # For running test, 1st build all:
  #   cmake --build .
  # Then run test with this command:
  #   cmake -E env CTEST_OUTPUT_ON_FAILURE=1 cmake --build . --target test
  # Or with this command:
  #   ctest --verbose
  # Env var CTEST_OUTPUT_ON_FAILURE or key --verbose are for show test outputs,
  # see
  # https://stackoverflow.com/a/37123943
  # https://stackoverflow.com/a/38386596
  
  # For Visual Studio:
  # https://stackoverflow.com/a/31124523
  # https://stackoverflow.com/a/37123943
  # cmake -E env CTEST_OUTPUT_ON_FAILURE=1 cmake --build . --target RUN_TESTS
  
endif()
