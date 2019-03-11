#!/bin/bash

setmode() {
	x=$1
	y=$2
	fps=$3
	display=$4

	modeline=$(cvt $x $y $fps | grep -oP '(?<=Modeline ).*')
	modename=$(echo $modeline | cut -f1 -d' ')

	xrandr --newmode $modeline
    xrandr --verbose --addmode $display $modename
    xrandr --output $display --mode $modename
}

desired_fps=50

wide_display=$(xrandr | egrep "connected (primary )?3440x1440" | cut -f1 -d' ')
if [ ! -z "$wide_display" ]; then
    echo "Connected to super-wide display ($wide_display), setting framerate to $desired_fps"
    setmode 3440 1440 $desired_fps $wide_display
else
    echo "Not connected to super-wide display, doing nothing."
fi

# wide_display=$(xrandr | egrep "connected primary" | cut -f1 -d' ')
# if [ ! -z "$wide_display" ]; then
#     echo "Connected to super-wide display ($wide_display), setting framerate to $desired_fps"
#     setmode 2560 1440 $desired_fps $wide_display
# else
#     echo "Not connected to super-wide display, doing nothing."
# fi