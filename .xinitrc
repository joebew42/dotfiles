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

export _JAVA_AWT_WM_NONREPARENTING=1

# Nvidia
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto
# xrandr --dpi 96

exec dbus-launch --exit-with-session i3
