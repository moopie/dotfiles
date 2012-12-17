#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# If using nvidia, execute this
if [ -z $(modprobe -i nvidia) ]; then
    nvidia-settings -a InitialPixmapPlacement=2
fi

# Keyboard and mouse stuff
xset r rate 180
xset mouse 22/7 1

# Don't forget to `mkdir ~/.wallpapers`
feh --bg-fill ~/.wallpapers/current.jpg &

urxvtd -q -o -f

dropboxd &

xsetroot -cursor_name Neutral

exec awesome
