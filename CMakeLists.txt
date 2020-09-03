#
# Copyright (c) 2019, New York University and Max Planck Gesellschaft.
#
# License BSD-3 clause
#

#
# Set up the project.
#
cmake_minimum_required(VERSION 3.10.2)

project(pybind11_catkin)

#
# Dependencies
#

# Find the ament cmake macros
find_package(ament_cmake REQUIRED)

# Load pybind11 located in this workspace.
exec_program(
  ${CMAKE_CURRENT_SOURCE_DIR}/scripts/find_pybind11 OUTPUT_VARIABLE
  pybind11_path
  RETURN_VALUE pybind11_found)

if(NOT ${pybind11_found})
  message(
    FATAL_ERROR
      "pybind11_catkin: failed to find pybind11 anywhere in the source directory"
  )
endif()
set(PYBIND11_SOURCE_PATH "${pybind11_path}")

# Find the usual dependencies
find_package(mpi_cmake_modules REQUIRED)
search_for_python()

#
# Install and Export dependencies
#
ament_export_include_directories(${PYTHON_INCLUDE_DIRS})
ament_export_include_directories(${PYBIND11_SOURCE_PATH}/include)
ament_export_libraries(${PYTHON_LIBRARIES})

install(DIRECTORY ${PYBIND11_SOURCE_PATH}/include/ DESTINATION include)

install(
  TARGETS
  EXPORT
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES
  DESTINATION include)



#
# building documentation
#
add_documentation()

#
# Export as an ament package
#
ament_package(CONFIG_EXTRAS cmake/pybind11_tools.cmake.in cmake/macros.cmake)
