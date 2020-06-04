######################
# set up the project #
######################
cmake_minimum_required(VERSION 3.5.1)
project(pybind11_catkin)

# required to use std::shared_ptr in code and to link the python bindings
if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wl,--no-as-needed")
endif()
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")

# use C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED on)

# ensuring path to libraries are set during install
set(CMAKE_SKIP_BUILD_RPATH  FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
set(CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_PREFIX}/lib)

##################################################
# Load the local pybind11 download through treep #
##################################################

# FIXME will this also work in install space?
EXEC_PROGRAM(${CMAKE_CURRENT_SOURCE_DIR}/scripts/find_pybind11
  OUTPUT_VARIABLE pybind11_path RETURN_VALUE pybind11_found)

if(NOT ${pybind11_found} MATCHES "0")
  MESSAGE(FATAL_ERROR "pybind11_catkin: failed to find pybind11 anywhere in the source directory")
endif()

set(PYBIND11_SOURCE_PATH "${pybind11_path}")

##########################################

find_package(catkin REQUIRED COMPONENTS
    mpi_cmake_modules)

search_for_python()

catkin_package(
    INCLUDE_DIRS
        ${PYTHON_INCLUDE_DIRS}
        ${PYBIND11_SOURCE_PATH}/include
    LIBRARIES
        ${PYTHON_LIBRARIES}
    CFG_EXTRAS
        pybind11_tools.cmake
        macros.cmake
    )

##########################
# building documentation #
##########################
build_doxygen_documentation()
