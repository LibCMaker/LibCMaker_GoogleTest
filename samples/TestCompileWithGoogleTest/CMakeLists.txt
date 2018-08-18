# ****************************************************************************
#  Project:  LibCMaker_GoogleTest
#  Purpose:  A CMake build script for Google Test library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2018 NikitaFeodonit
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

cmake_minimum_required(VERSION 3.3)

project(LibCMaker_GoogleTest_Compile_Test CXX)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(cmr_PRINT_DEBUG ON)


#-----------------------------------------------------------------------
# Configure to find_package()
#-----------------------------------------------------------------------

# Set CMake's search path for find_*() commands.
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")

if(ANDROID)
  list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX}")
endif()


#-----------------------------------------------------------------------
# Set path to LibCMaker root
#-----------------------------------------------------------------------

set(LibCMaker_DIR "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker")
# Uncomment it if need functions from LibCMaker
#list(APPEND CMAKE_MODULE_PATH "${LibCMaker_DIR}/cmake")


#-----------------------------------------------------------------------
# Set vars for LibCMaker_GoogleTest
#-----------------------------------------------------------------------

set(GOOGLETEST_lib_NAME     "GoogleTest")
set(GOOGLETEST_lib_VERSION  "1.8.20180314")
set(GOOGLETEST_lib_DIR  "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker_GoogleTest")

# To use below for sample sources.
set(cmr_UNPACKED_DIR ${CMAKE_CURRENT_BINARY_DIR}/download/unpacked)

# To use our FindGTest.cmake.
list(APPEND CMAKE_MODULE_PATH "${GOOGLETEST_lib_DIR}/cmake/modules")

option(BUILD_TESTING "Build the testing tree." ON)


#-----------------------------------------------------------------------
# Library specific vars and options
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Common Google Test and Google Mock options
#
option(BUILD_GTEST "Builds the googletest subproject" ON)
# Note that googlemock target already builds googletest.
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
  ON
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
# FindGTest.cmake options
#
# From "FindGTest.cmake":
#   If compiling with MSVC, this variable can be set to ``MT`` or
#   ``MD`` (the default) to enable searching a GTest build tree
if(MSVC)
  set(GTEST_MSVC_SEARCH "MT")
endif()


#-----------------------------------------------------------------------
# Build, install and find the GoogleTest
#-----------------------------------------------------------------------

# Make build and install the library at a config CMake phase.
include(${LibCMaker_DIR}/cmake/cmr_find_package.cmake)
cmr_find_package(
  LibCMaker_DIR   ${LibCMaker_DIR}
  NAME            ${GOOGLETEST_lib_NAME}
  VERSION         ${GOOGLETEST_lib_VERSION}
  LIB_DIR         ${GOOGLETEST_lib_DIR}
  REQUIRED
  FIND_MODULE_NAME GTest
)


#-----------------------------------------------------------------------
# Link to the library
#-----------------------------------------------------------------------

# Build test library.

# Get an example sources from the lib sources.
set(src_commit "a325ad2db5deb623eab740527e559b81c0f39d65")
set(lib_EXAMPLES_SRC_DIR
  "${cmr_UNPACKED_DIR}/googletest-${GOOGLETEST_lib_VERSION}/googletest-${src_commit}/googletest/samples"
)

add_library(${PROJECT_NAME}_lib
  ${lib_EXAMPLES_SRC_DIR}/sample1.h
  ${lib_EXAMPLES_SRC_DIR}/sample1.cc
)

# Testing with Google Test.
if(BUILD_TESTING)
  enable_testing()
  add_executable(${PROJECT_NAME}_unittest
    ${lib_EXAMPLES_SRC_DIR}/sample1_unittest.cc
  )
  target_link_libraries(${PROJECT_NAME}_unittest
    ${PROJECT_NAME}_lib       # Our lib for testing.
    GTest::GTest GTest::Main  # GTest libs.
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
