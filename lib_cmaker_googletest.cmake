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

## +++ Common part of the lib_cmaker_<lib_name> function +++
set(lib_NAME "GoogleTest")

# To find library's LibCMaker source dir.
set(lcm_${lib_NAME}_SRC_DIR ${CMAKE_CURRENT_LIST_DIR})

if(NOT LIBCMAKER_SRC_DIR)
  message(FATAL_ERROR
    "Please set LIBCMAKER_SRC_DIR with path to LibCMaker root.")
endif()

include(${LIBCMAKER_SRC_DIR}/cmake/modules/lib_cmaker_init.cmake)

function(lib_cmaker_googletest)

  # Make the required checks.
  # Add library's and common LibCMaker module paths to CMAKE_MODULE_PATH.
  # Unset lcm_CMAKE_ARGS.
  # Set vars:
  #   cmr_CMAKE_MIN_VER
  #   cmr_lib_cmaker_main_PATH
  #   cmr_printers_PATH
  #   lower_lib_NAME
  # Parce args and set vars:
  #   arg_VERSION
  #   arg_DOWNLOAD_DIR
  #   arg_UNPACKED_DIR
  #   arg_BUILD_DIR
  lib_cmaker_init(${ARGN})

  include(${cmr_lib_cmaker_main_PATH})
  include(${cmr_printers_PATH})

  cmake_minimum_required(VERSION ${cmr_CMAKE_MIN_VER})
## --- Common part of the lib_cmaker_<lib_name> function ---


  #-----------------------------------------------------------------------
  # Library specific build arguments
  #-----------------------------------------------------------------------

## +++ Common part of the lib_cmaker_<lib_name> function +++
  set(cmr_LIB_VARS
    BUILD_GTEST
    BUILD_GMOCK
    gtest_force_shared_crt
    gtest_build_tests
    gtest_build_samples
    gtest_disable_pthreads
    gtest_hide_internal_symbols
    gmock_build_tests
  )

  foreach(d ${cmr_LIB_VARS})
    if(DEFINED ${d})
      list(APPEND lcm_CMAKE_ARGS
        -D${d}=${${d}}
      )
    endif()
  endforeach()
## --- Common part of the lib_cmaker_<lib_name> function ---


  #-----------------------------------------------------------------------
  # Building
  #-----------------------------------------------------------------------

## +++ Common part of the lib_cmaker_<lib_name> function +++
  cmr_lib_cmaker_main(
    NAME          ${lib_NAME}
    VERSION       ${arg_VERSION}
    BASE_DIR      ${lcm_${lib_NAME}_SRC_DIR}
    DOWNLOAD_DIR  ${arg_DOWNLOAD_DIR}
    UNPACKED_DIR  ${arg_UNPACKED_DIR}
    BUILD_DIR     ${arg_BUILD_DIR}
    CMAKE_ARGS    ${lcm_CMAKE_ARGS}
    INSTALL
  )
## --- Common part of the lib_cmaker_<lib_name> function ---

  # Release lib must be builded for debug type.
  # TODO: for multi-configuration generators, see:
  # https://stackoverflow.com/a/24470998
  if(CMAKE_CFG_INTDIR STREQUAL "." AND CMAKE_BUILD_TYPE STREQUAL "Debug")
    cmr_print_message("Build the Release library type.")
    set(CMAKE_BUILD_TYPE "Release")
## +++ Common part of the lib_cmaker_<lib_name> function +++
    cmr_lib_cmaker_main(
      NAME          ${lib_NAME}
      VERSION       ${arg_VERSION}
      BASE_DIR      ${lcm_${lib_NAME}_SRC_DIR}
      DOWNLOAD_DIR  ${arg_DOWNLOAD_DIR}
      UNPACKED_DIR  ${arg_UNPACKED_DIR}
      BUILD_DIR     ${arg_BUILD_DIR}
      CMAKE_ARGS    ${lcm_CMAKE_ARGS}
      INSTALL
    )
## --- Common part of the lib_cmaker_<lib_name> function ---
  endif()

endfunction()
