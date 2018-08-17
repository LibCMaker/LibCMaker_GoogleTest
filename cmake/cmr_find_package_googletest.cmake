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

# Part of "LibCMaker/cmake/cmr_find_package.cmake".

  #-----------------------------------------------------------------------
  # Library specific build arguments
  #-----------------------------------------------------------------------

## +++ Common part of the lib_cmaker_<lib_name> function +++
  set(find_LIB_VARS
    BUILD_GTEST
    BUILD_GMOCK
    gtest_force_shared_crt
    gtest_build_tests
    gtest_build_samples
    gtest_disable_pthreads
    gtest_hide_internal_symbols
    gmock_build_tests
  )

  foreach(d ${find_LIB_VARS})
    if(DEFINED ${d})
      list(APPEND find_CMAKE_ARGS
        -D${d}=${${d}}
      )
    endif()
  endforeach()
## --- Common part of the lib_cmaker_<lib_name> function ---


  #-----------------------------------------------------------------------
  # Building
  #-----------------------------------------------------------------------

  set(GTEST_lib_LANGUAGES CXX C)

## +++ Common part of the lib_cmaker_<lib_name> function +++
  cmr_lib_cmaker_main(
    LibCMaker_DIR ${find_LibCMaker_DIR}
    NAME          ${find_NAME}
    VERSION       ${find_VERSION}
    LANGUAGES     ${GTEST_lib_LANGUAGES}
    BASE_DIR      ${find_LIB_DIR}
    DOWNLOAD_DIR  ${cmr_DOWNLOAD_DIR}
    UNPACKED_DIR  ${cmr_UNPACKED_DIR}
    BUILD_DIR     ${lib_BUILD_DIR}
    CMAKE_ARGS    ${find_CMAKE_ARGS}
    INSTALL
  )
## --- Common part of the lib_cmaker_<lib_name> function ---

  # Release lib must be builded for debug type.
  # TODO: for multi-configuration generators, see:
  # https://stackoverflow.com/a/24470998
  if(CMAKE_CFG_INTDIR STREQUAL "." AND CMAKE_BUILD_TYPE STREQUAL "Debug")
    cmr_print_status("Build the Release library type.")
    set(CMAKE_BUILD_TYPE "Release")
## +++ Common part of the lib_cmaker_<lib_name> function +++
    cmr_lib_cmaker_main(
      LibCMaker_DIR ${find_LibCMaker_DIR}
      NAME          ${find_NAME}
      VERSION       ${find_VERSION}
      LANGUAGES     ${GTEST_lib_LANGUAGES}
      BASE_DIR      ${find_LIB_DIR}
      DOWNLOAD_DIR  ${cmr_DOWNLOAD_DIR}
      UNPACKED_DIR  ${cmr_UNPACKED_DIR}
      BUILD_DIR     ${lib_BUILD_DIR}
      CMAKE_ARGS    ${find_CMAKE_ARGS}
      INSTALL
    )
## --- Common part of the lib_cmaker_<lib_name> function ---
  endif()
