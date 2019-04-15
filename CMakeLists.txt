######################
# set up the project #
######################
cmake_minimum_required(VERSION 3.5.1)

project(pybind11_catkin)

# required to use std::shared_ptr in code
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wl,--no-as-needed")

# ensuring path to libraries are set during install
set(CMAKE_SKIP_BUILD_RPATH  FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
set(CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_PREFIX}/lib)

################################################
# Load the local pybind11 download throw treep #
################################################

set(pybind11_treep_clone_dir "${CMAKE_SOURCE_DIR}/not_catkin/third_party/pybind11")
add_subdirectory(${pybind11_treep_clone_dir} tmp_${PROJECT_NAME})

###############################################
# For cmake to find the FindXXXXX.cmake files #
###############################################

list(APPEND CMAKE_MODULE_PATH "${pybind11_treep_clone_dir}/tools/")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} PARENT_SCOPE)

##########################################
# export the package as a catkin package #
##########################################

catkin_package(
  INCLUDE_DIRS ${pybind11_treep_clone_dir}/include
  LIBRARIES
  CFG_EXTRAS ${pybind11_treep_clone_dir}/tools/pybind11Tools.cmake
)
