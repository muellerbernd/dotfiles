#!/usr/bin/env bash

if [ -z $(pidof gammastep) ]; then
    gammastep -o -O 3700 &
else
    kill -9 $(pidof gammastep)
fi
