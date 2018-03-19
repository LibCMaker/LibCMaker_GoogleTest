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

include(cmr_get_version_parts)
include(cmr_print_fatal_error)

function(cmr_googletest_get_download_params
    version
    out_url out_sha out_src_dir_name out_tar_file_name)

  set(lib_base_url "https://github.com/google/googletest/archive")

  if(version VERSION_EQUAL "1.8.20171222")
    set(lib_sha
      "fb94ea2c653f239fb57e423afef372ebb5e019418af58f8bb2ce946679a6187b")
    set(lib_commit
      "5490beb0602eab560fa3969a4410e11d94bf12af")
  endif()
  if(version VERSION_EQUAL "1.8.20180314")
    set(lib_sha
      "2280d3889d21a2ce3b6d38e4cc1f7d462068652675864075ed78a2709bc32bef")
    set(lib_commit
      "a325ad2db5deb623eab740527e559b81c0f39d65")
  endif()

  if(NOT DEFINED lib_sha)
    cmr_print_fatal_error("Library version ${version} is not supported.")
  endif()

  set(lib_src_name "googletest-${lib_commit}")
  set(lib_tar_file_name "${lib_src_name}.zip")
  set(lib_url "${lib_base_url}/${lib_commit}.zip")

  set(${out_url} "${lib_url}" PARENT_SCOPE)
  set(${out_sha} "${lib_sha}" PARENT_SCOPE)
  set(${out_src_dir_name} "${lib_src_name}" PARENT_SCOPE)
  set(${out_tar_file_name} "${lib_tar_file_name}" PARENT_SCOPE)
endfunction()
