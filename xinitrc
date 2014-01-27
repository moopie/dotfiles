#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# If using nvidia, execute some stuff that supposedly improves performance
# https://wiki.archlinux.org/index.php/Nvidia#GUI:_nvidia-settings
if [ -z $(modprobe -i nvidia) ]; then
    nvidia-settings -a InitialPixmapPlacement=2
fi

# Keyboard and mouse rate; increases their responsiveness
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

# Use xbindkeys for all the hotkeys that don't require to be set up with a WM
# like applications and other things (check ~/.xbindkeysrc for the full list)
xbindkeys

# Cursor theme (requires xcursor-neutral)
xsetroot -cursor_name Neutral

# Merge the custom Xresources settings with the default ones
xrdb -merge ~/.Xresources

# Automatically loads the last wallpaper that was set up with feh
sh ~/.fehbg

# Urxvt daemon, for faster urxvt
urxvtd -q -o -f

# Tmux sessions
tmux new -d -s dev
tmux new -d -s music ncmpcpp

# Our little status bar
xmobar ~/.xmonad/xmobarrc &

# Here we go...
exec xmonad
