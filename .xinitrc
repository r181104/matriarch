#!/bin/sh

xset r rate 200 50

xset -b

numlockx &

xinput --set-prop "pointer:<your-touchpad-name>" "libinput Tapping Enabled" 1
xinput --set-prop "pointer:<your-touchpad-name>" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "pointer:<your-touchpad-name>" "libinput Disable While Typing Enabled" 1
xinput --set-prop "pointer:<your-touchpad-name>" "libinput Accel Speed" 0.3
xinput --set-prop "pointer:<your-touchpad-name>" "libinput Scroll Method Enabled" 0 0 1

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

exec dwm
