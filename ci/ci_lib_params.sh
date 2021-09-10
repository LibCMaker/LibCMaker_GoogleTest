#!/bin/bash

# ****************************************************************************
#  Project:  LibCMaker_libpng
#  Purpose:  A CMake build script for libpng library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2021 NikitaFeodonit
#
#    This file is part of the LibCMaker_libpng project.
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

set -e

if [[ ${cmr_CI} == "ON" ]]; then
  set -v
fi

cmr_LIB_DEPS_NAMES=(
"LibCMaker"
"LibCMaker_GoogleTest"
)


# ==== Set variables, only for Google Test ====

if [[ ${cmr_TARGET} == "Windows_MSVC" ]] ; then
  export PATH=${cmr_BUILD_DIR}/${cmr_CMAKE_BUILD_TYPE}:${PATH}
elif [[ ${cmr_TARGET} == "Windows_MinGW-w64" ]] ; then
  export PATH=${cmr_BUILD_DIR}:${PATH}
fi
