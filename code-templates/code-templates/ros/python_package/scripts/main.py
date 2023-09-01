#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# File              : main.py
# Author            : Bernd Müller <bernd@muellerbernd.de>
# Date              : 23.11.2021
# Last Modified Date: 18.01.2022
# Last Modified By  : Bernd Müller <bernd@muellerbernd.de>
import rospy
from std_msgs.msg import Bool
from geometry_msgs.msg import Twist
from sensor_msgs.msg import Joy

from goetting_hg_08230_msgs.msg import Status
from kate_blinker_interface_msgs.msg import Blinker, BlinkerSequence


class KateLineFollower:
    def __init__(self):
        rospy.init_node("kate_follow_line_node", anonymous=True)
        # try to read parameters
        try:
            self.speed = rospy.get_param("~driving_speed")
            self.kate_status_topic = rospy.get_param("~kate_status_topic")
            self.kate_follow_line_topic = rospy.get_param("~kate_follow_line_topic")
            self.joy_topic = "/joy"
        except Exception as e:
            rospy.logerr(e)
            rospy.signal_shutdown(e)

        # publishers
        self.line_follow_pub = rospy.Publisher(
            self.kate_follow_line_topic, Bool, queue_size=10
        )
        self.cmd_pub = rospy.Publisher("cmd_vel", Twist, queue_size=10)
        self.blink_pub = rospy.Publisher(
            "/goetting_k_08245_zb_node/blink", Blinker, queue_size=10
        )

        # subscribers for kate status and joy messages
        rospy.Subscriber(self.kate_status_topic, Status, self.kate_status_callback)
        rospy.Subscriber(self.joy_topic, Joy, self.kate_joy_callback)

        # status variables
        self.is_on_line = False
        self.last_time_line = rospy.Time.now()
        self.line_follow_enabled = False

        # timer for sending drive commands
        self.command_timer = rospy.Timer(rospy.Duration(0.05), self.send_command)
        # status timer
        self.timer = rospy.Timer(rospy.Duration(0.05), self.status_timer)

        rospy.loginfo("kate_line_follower ready")
        rospy.spin()

    def kate_status_callback(self, msg: Status):
        """
        callback function that reads the given status message
        """
        self.is_on_line = msg.line_detected
        if self.is_on_line:
            self.last_time_line = rospy.Time.now()

    def kate_joy_callback(self, msg: Joy):
        """
        For more informations see ros wiki
        http://wiki.ros.org/joy
        """
        start_button = msg.buttons[0]
        if start_button != 0:
            # A button on Logitech Wireless Gamepad F710
            self.line_follow_enabled = True
            self.line_follow_pub.publish(Bool(True))
            rospy.logwarn("Line follow mode enabled")
            self.blink_enable()
        stop_button = msg.buttons[1]
        if stop_button != 0:
            # B button on Logitech Wireless Gamepad F710
            self.line_follow_enabled = False
            rospy.logwarn("Line follow mode disabled")
            # disable line follow mode
            self.autonomous_mode_disable()

    def send_command(self, event):
        """
        Timer function that sends twist command for driving speed
        """
        if not rospy.is_shutdown() and self.is_on_line and self.line_follow_enabled:
            new_twist = Twist()
            new_twist.linear.x = self.speed
            self.cmd_pub.publish(new_twist)

    def blink_enable(self):
        """
        flash with blinker when line follow mode is activated
        write blinker msg to /kate_interface_board/blink
        """
        if not rospy.is_shutdown() and self.line_follow_enabled:
            blink = Blinker()
            blink_seq = BlinkerSequence()
            blink_seq.front_blinker_left = True  # The state (ON/OFF) of the front left blinker. (ON := true; OFF := false)
            blink_seq.front_blinker_right = True  # The state (ON/OFF) of the front right blinker. (ON := true; OFF := false)
            blink_seq.rear_blinker_left = True  # The state (ON/OFF) of the rear left blinker. (ON := true; OFF := false)
            blink_seq.rear_blinker_right = True  # The state (ON/OFF) of the rear right blinker. (ON := true; OFF := false)
            blink_seq.duration = (
                0.5  # The duration in seconds, how long the state have to be held.
            )
            blink.sequence.append(blink_seq)
            blink_seq = BlinkerSequence()
            blink_seq.front_blinker_left = False  # The state (ON/OFF) of the front left blinker. (ON := true; OFF := false)
            blink_seq.front_blinker_right = False  # The state (ON/OFF) of the front right blinker. (ON := true; OFF := false)
            blink_seq.rear_blinker_left = False  # The state (ON/OFF) of the rear left blinker. (ON := true; OFF := false)
            blink_seq.rear_blinker_right = False  # The state (ON/OFF) of the rear right blinker. (ON := true; OFF := false)
            blink_seq.duration = (
                0.5  # The duration in seconds, how long the state have to be held.
            )
            blink.sequence.append(blink_seq)
            self.blink_pub.publish(blink)

    def status_timer(self, event):
        """
        this Timer function tests if the robot is still on the line
        """
        now = rospy.Time.now()
        diff = (now - self.last_time_line).to_sec()
        if diff >= 5 and self.line_follow_enabled:
            rospy.logwarn(
                "Found no Line, autonomous mode disabled, you need to enable teleoperation mode"
            )
            self.autonomous_mode_disable()

    def autonomous_mode_disable(self):
        """
        function for disabling autonomous mode
        """
        self.line_follow_enabled = False
        self.line_follow_pub.publish(Bool(False))
        blink = Blinker()
        self.blink_pub.publish(blink)


def shutdown_h():
    # disable blinker
    blink_pub = rospy.Publisher(
        "/goetting_k_08245_zb_node/blink", Blinker, queue_size=10
    )
    blink = Blinker()
    blink_pub.publish(blink)
    rospy.loginfo("Ros shutdown")


if __name__ == "__main__":
    rospy.on_shutdown(shutdown_h)
    try:
        klf = KateLineFollower()

    except rospy.ROSInterruptException:
        rospy.loginfo("Ros Interrupt")
