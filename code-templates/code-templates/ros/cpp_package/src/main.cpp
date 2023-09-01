#include "icp_matcher.h"
#include <iostream>
#include <ros/ros.h>
int main(int argc, char **argv)
{
    ros::init(argc, argv, "icp_matcher_node");
    ros::NodeHandle nh;

    IcpMatcher icpMatcherObj(&nh, "icp_matcher_node");
    ros::Timer timer = nh.createTimer(
        ros::Duration(0.1), &IcpMatcher::timerCallback,
        &icpMatcherObj);
    ros::spin();
}
