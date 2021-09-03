#!/usr/bin/env bash

xrandr --output eDP1 --auto --left-of HDMI1
xrandr --output eDP1 --mode 1920x1080
xrandr --output DP2 --auto --right-of HDMI1
