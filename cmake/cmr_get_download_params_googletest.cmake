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

# Part of "LibCMaker/cmake/cmr_get_download_params.cmake".

  if(version VERSION_EQUAL "1.8.20171222")
    set(arch_file_sha
      "95942bceb023566ff2eb8c4d6ad9980394c5952c907bf3e3b93a0403bf89fed1")
    set(src_commit
      "5490beb0602eab560fa3969a4410e11d94bf12af")
  endif()
  if(version VERSION_EQUAL "1.8.20180314")
    set(arch_file_sha
      "39c1ce3e3a004d1982708d5cb6993b31ae0aed3386ca2fb11c37fe9fef3a6508")
    set(src_commit
      "a325ad2db5deb623eab740527e559b81c0f39d65")
  endif()
  if(version VERSION_EQUAL "1.10.20200425")
    set(arch_file_sha
      "39275312b3f169fd0fbdccb7c74e3ba0b2ca78c54ca69909d774da9bcb96e2ae")
    set(src_commit
      "dcc92d0ab6c4ce022162a23566d44f673251eee4")
  endif()
  if(version VERSION_EQUAL "1.11.20210904")
    set(arch_file_sha
      "4a50c2c3e8d8d332fa82b96390a9bfc7ab0e2a900dd7e301868c3886270c1cc8")
    set(src_commit
      "955c7f837efad184ec63e771c42542d37545eaef")
  endif()
  if(version VERSION_EQUAL "1.11.20211031")
    set(arch_file_sha
      "879a4064738cb3c76a11d449145b442654d7282f3cd0f5f03ec8c3dc862646c6")
    set(src_commit
      "16f637fbf4ffc3f7a01fa4eceb7906634565242f")
  endif()
  if(version VERSION_EQUAL "1.11.20220426")
    set(arch_file_sha
      "e22fb11e8339abffb32124c6a857c5977b7cc488152ec72c5731d54e02f0fa0f")
    set(src_commit
      "b53547bf01ee6d5c547bc539a498c49bc6027169")
  endif()

  set(base_url "https://github.com/google/googletest/archive")
  set(src_dir_name    "googletest-${version}")
  set(arch_file_name  "${src_dir_name}.tar.gz")
  set(unpack_to_dir   "${unpacked_dir}/${src_dir_name}")

  set(${out_ARCH_SRC_URL}   "${base_url}/${src_commit}.tar.gz" PARENT_SCOPE)
  set(${out_ARCH_DST_FILE}  "${download_dir}/${arch_file_name}" PARENT_SCOPE)
  set(${out_ARCH_FILE_SHA}  "${arch_file_sha}" PARENT_SCOPE)
  set(${out_SHA_ALG}        "SHA256" PARENT_SCOPE)
  set(${out_UNPACK_TO_DIR}  "${unpack_to_dir}" PARENT_SCOPE)
  set(${out_UNPACKED_SOURCES_DIR}
    "${unpack_to_dir}/googletest-${src_commit}" PARENT_SCOPE
  )
  set(${out_VERSION_BUILD_DIR} "${build_dir}/${src_dir_name}" PARENT_SCOPE)
