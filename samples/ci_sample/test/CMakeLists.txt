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

# Testing with Google Test.
if(BUILD_TESTING)
  cmr_common_sample_test_1_part()

  target_sources(${test_NAME}
    PRIVATE
      ${test_src_DIR}/sample1_unittest.cc
  )
  set_target_properties(${test_NAME} PROPERTIES
    CXX_STANDARD 11
    C_STANDARD 11
  )

  # Our lib for testing.
  target_link_libraries(${test_NAME} PRIVATE
    ${PROJECT_NAME}
  )

  cmr_common_sample_test_2_part()
endif()


#-----------------------------------------------------------------------
# FailTest
#-----------------------------------------------------------------------

if(BUILD_TESTING AND NOT ANDROID AND NOT IOS)
  set(test_NAME "FailTest")
  add_executable(${test_NAME} ${IOS_MACOSX_BUNDLE} "")

  target_sources(${test_NAME}
    PRIVATE
      ${test_src_DIR}/fail-test.cpp
  )
  set_target_properties(${test_NAME} PROPERTIES
    CXX_STANDARD 11
    C_STANDARD 11
  )

  if(WIN32 AND MSVC AND (TARGETING_XP_64 OR TARGETING_XP))
    if(TARGETING_XP_64)
      set(_EXE_SUBSYSTEM_VER "5.02")
    elseif(TARGETING_XP)
      set(_EXE_SUBSYSTEM_VER "5.01")
    endif()

    # See docs for add_executable() and WIN32_EXECUTABLE.
    #set_property(TARGET ${test_NAME} PROPERTY WIN32_EXECUTABLE ON)
    get_target_property(_WIN32_EXECUTABLE ${test_NAME} WIN32_EXECUTABLE)
    if(_WIN32_EXECUTABLE)
      set(_EXE_SUBSYSTEM "WINDOWS")
    else()
      set(_EXE_SUBSYSTEM "CONSOLE")
    endif()

    target_link_options(${test_NAME} PRIVATE
      "/SUBSYSTEM:${_EXE_SUBSYSTEM},${_EXE_SUBSYSTEM_VER}"
    )
  endif()

  cmr_common_sample_test_2_part_2()

  set_tests_properties(${test_NAME} PROPERTIES
    PASS_REGULAR_EXPRESSION "\\[  FAILED  \\] FailTest.FailTest"
  )
endif()
