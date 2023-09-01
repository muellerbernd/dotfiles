cmake_minimum_required(VERSION 2.8.3)
project(icp_matcher)

find_package(catkin REQUIRED COMPONENTS
    roscpp
    rtls_msgs
    tf2_geometry_msgs
    tf2_ros
    tf2
    # test
    std_msgs
    genmsg
    )

catkin_package(
    INCLUDE_DIRS include
    CATKIN_DEPENDS roscpp tf2_ros
    )

include_directories(
    include
    ${catkin_INCLUDE_DIRS}
    )

add_executable(icp_matcher_node
    src/main.cpp
    src/icp_matcher/icp_matcher.cpp
    )

target_link_libraries(icp_matcher_node
    ${catkin_LIBRARIES}
    )

add_dependencies(icp_matcher_node ${catkin_EXPORTED_TARGETS})
set( CMAKE_EXPORT_COMPILE_COMMANDS ON )

