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

# Keyboard layouts
setxkbmap \
    -layout us,il,ru \
    -variant dvorak,,winkeys \
    -option \
    -option grp:caps_toggle \
    -option grp_led:scroll \
    -option compose:rctrl \
    -option lv3:ralt_switch \
    -option terminate:ctrl_alt_bkspc

# Cursor theme
xsetroot -cursor_name left_ptr

sh ~/.fehbg

urxvtd -q -o -f

xbindkeys

xautolock &

gnome-screensaver &

#dropboxd &

exec xmonad
