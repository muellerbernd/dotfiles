#ifndef ICPMATCHER
#define ICPMATCHER

#include "std_msgs/String.h"
#include <ros/ros.h>
#include <string.h>

class IcpMatcher
{
  public:
    IcpMatcher(ros::NodeHandle *nh, std::string node_name);
    void timerCallback(const ros::TimerEvent &);

  private:
    bool m_debug;

    ros::NodeHandle m_nh, m_private_nh;

    ros::Publisher m_tag0AnglePub;
    ros::Publisher m_tag1AnglePub;
    ros::Publisher m_meanAnglePub;
    ros::Subscriber m_tag0AnchorsSub;
    ros::Subscriber m_tag1AnchorsSub;

    // functions
    // void tag0PosCallback(const rtls_msgs::RtlsPoint::ConstPtr &msg);
    // void tag0AnchorsCallback(const rtls_msgs::RtlsAnchors::ConstPtr &msg);
    // void tag1PosCallback(const rtls_msgs::RtlsPoint::ConstPtr &msg);
    // void tag1AnchorsCallback(const rtls_msgs::RtlsAnchors::ConstPtr &msg);
    // void publishAngle(double angle, std::string id16, int numberOfAnchors,
    //                   int numberOfTags, const ros::Publisher &pub);
    // double calculateAngle(int tag);
    // double calculateTiltAngle(int tag);
    // double calculateSideTiltAngle(int tag);
    // std::pair<double, double>
    // calculateMovAvgs(int tag, std::pair<double, double> anchorDistances);
    // double calculateMovAvg(int tag, double anchorDist,
    //                        std::deque<double> *movAvgWindow);
    // std::pair<double, double> getCurrentDistances(int tag);
};

#endif // ICPMATCHER
