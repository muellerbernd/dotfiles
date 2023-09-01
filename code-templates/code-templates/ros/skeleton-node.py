#!/usr/bin/env python

import rospy

import numpy as np
import math
from pathlib import Path
import gc


if __name__ == "__main__":
    try:
        Path(plot_path).mkdir(parents=True, exist_ok=True)
    except rospy.ROSException:
        print("could not get param name")
    except (rospy.ROSInterruptException, KeyboardInterrupt):
        # Reset by pressing CTRL + C
        p
