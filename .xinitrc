#!/bin/sh

# Source scripts in /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

setxkbmap it

# Disable screen blanking
xset -dpms &
xset s noblank &
xset s off &

# Mouse
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'Device Accel Constant Deceleration' 5

exec dbus-launch --exit-with-session i3
