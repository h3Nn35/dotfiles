#!/bin/sh

# Hauptbildschirm
xrandr --output HDMI-1 --mode 1920x1080 --primary --pos 0x0 --rotate normal

# zweiter monitor
xrandr --output DP-3 --mode 1920x1080 --pos 1920x0 --rotate normal

