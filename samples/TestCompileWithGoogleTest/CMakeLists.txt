# ****************************************************************************
#  Project:  LibCMaker_GoogleTest
#  Purpose:  A CMake build script for Google Test library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2019 NikitaFeodonit
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

cmake_minimum_required(VERSION 3.4)

project(LibCMaker_GoogleTest_Compile_Test CXX)

option(CMAKE_VERBOSE_MAKEFILE "CMAKE_VERBOSE_MAKEFILE" OFF)
option(cmr_PRINT_DEBUG "cmr_PRINT_DEBUG" OFF)


#-----------------------------------------------------------------------
# Configure to find_package()
#-----------------------------------------------------------------------

# Set CMake's search path for find_*() commands.
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")

if(ANDROID)
  list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX}")
endif()


#-----------------------------------------------------------------------
# Set path vars
#-----------------------------------------------------------------------

set(libs_DIR "${CMAKE_CURRENT_LIST_DIR}/libs")
set(cmr_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}")
# To use below for sample sources.
set(cmr_UNPACKED_DIR ${CMAKE_CURRENT_BINARY_DIR}/download/unpacked)


#-----------------------------------------------------------------------
# LibCMaker settings
#-----------------------------------------------------------------------

set(LibCMaker_DIR "${libs_DIR}/LibCMaker")
list(APPEND CMAKE_MODULE_PATH "${LibCMaker_DIR}/cmake")
include(cmr_find_package)


#-----------------------------------------------------------------------
# Download, configure, build, install and find the required libraries
#-----------------------------------------------------------------------

option(BUILD_TESTING "Build the testing tree." OFF)
if(BUILD_TESTING)
  enable_testing()
  include(${libs_DIR}/LibCMaker_GoogleTest/cmr_build_googletest.cmake)
endif()


#-----------------------------------------------------------------------
# Build the test library
#-----------------------------------------------------------------------

# Get an example sources from the lib sources.
set(src_commit "a325ad2db5deb623eab740527e559b81c0f39d65")
set(lib_EXAMPLES_SRC_DIR
  "${cmr_UNPACKED_DIR}/googletest-${GTEST_lib_VERSION}/googletest-${src_commit}/googletest/samples"
)

add_library(${PROJECT_NAME}
  ${lib_EXAMPLES_SRC_DIR}/sample1.h
  ${lib_EXAMPLES_SRC_DIR}/sample1.cc
)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)


#-----------------------------------------------------------------------
# Testing
#-----------------------------------------------------------------------

set(test_src_DIR "${CMAKE_CURRENT_LIST_DIR}/src")
add_subdirectory(test)
