#!/bin/sh

xset r rate 200 50

xset -b

numlockx &

xset s off -dpms

xinput --set-prop "Elan Touchpad" "libinput Tapping Enabled" 1
xinput --set-prop "Elan Touchpad" "libinput Natural Scrolling Enabled" 0
xinput --set-prop "Elan Touchpad" "libinput Disable While Typing Enabled" 1
xinput --set-prop "Elan Touchpad" "libinput Accel Speed" 2
xinput --set-prop "Elan TrackPoint" "libinput Accel Speed" 0

xrandr --output eDP1 --mode 1920x1080 --rate 60.00
xrandr --output eDP2 --mode 1920x1080 --rate 60.00
xrandr --output eDP3 --mode 1920x1080 --rate 60.00
xrandr --output eDP4 --mode 1920x1080 --rate 60.00
xrandr --output eDP-1 --mode 1920x1080 --rate 60.00
xrandr --output eDP-2 --mode 1920x1080 --rate 60.00
xrandr --output eDP-3 --mode 1920x1080 --rate 60.00
xrandr --output eDP-4 --mode 1920x1080 --rate 60.00

dunst & disown
picom & disown
