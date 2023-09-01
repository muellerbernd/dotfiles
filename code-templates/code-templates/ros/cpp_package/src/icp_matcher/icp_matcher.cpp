#include "icp_matcher.h"
#include "geometry_msgs/PointStamped.h"
#include "geometry_msgs/QuaternionStamped.h"
#include <math.h>
#include "std_msgs/String.h"
#include "tf2_geometry_msgs/tf2_geometry_msgs.h"
#include <cmath>
#include <iostream>
#include <string>

IcpMatcher::IcpMatcher(ros::NodeHandle *nh, std::string node_name)
    : m_private_nh(node_name), m_debug(true)
{
    // ros::param::param("~/fixed_params/l_trailer", m_lTrailer, 0.0);
    // ros::param::param("~/fixed_params/l_shuttle", m_lShuttle, 0.0);
    // ros::param::param("~/fixed_params/l_drawbar", m_lDrawbar, 0.0);
    // ros::param::param("~/fixed_params/h_trailer", m_hTrailer, 0.0);
    // ros::param::param("~/fixed_params/h_shuttle", m_hShuttle, 0.0);

    ROS_INFO("IcpMatcher started");
}

/**
 * timer callback function that checks which tag is still available
 *
 * @param timerevent
 */
void IcpMatcher::timerCallback(const ros::TimerEvent &)
{
    ROS_INFO_COND(m_debug, "IcpMatcher started");
}
