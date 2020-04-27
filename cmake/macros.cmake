
# Create a Python module using pybind11
#
# Args:
#     module_name:  The name of the module.  This macro expects the
#         implementation to be found in a file `srcpy/${module_name}.cpp`.
#     ARGN:  Any additional arguments are added to `target_link_libraries` so
#         use this for any additional libraries that are not already covered by
#         `${catkin_LIBRARIES}`.
macro(catkin_add_pybind11_module module_name)
    pybind11_add_module(${module_name} srcpy/${module_name}.cpp)
    target_link_libraries(${module_name} PRIVATE
        ${catkin_LIBRARIES} ${ARGN})
    set_target_properties(${module_name} PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_PYTHON_DESTINATION})
    install(TARGETS ${module_name} DESTINATION ${CATKIN_PACKAGE_PYTHON_DESTINATION})
endmacro()

