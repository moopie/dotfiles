#!/bin/sh

execdir () {
    if [ -d "$1" ]; then
        for f in "$1"/*; do
            if [ -x "$f" ]; then . "$f" ; fi
        done
        unset f
    fi
}

execdir /etc/X11/xinit/xinitrc.d 

# If using nvidia, execute some stuff that supposedly improves performance
# https://wiki.archlinux.org/index.php/Nvidia#GUI:_nvidia-settings
if [ $(lsmod | grep nvidia &> /dev/null) ]; then
    nvidia-settings -a InitialPixmapPlacement=2
fi

# Keyboard and mouse rate; increases their responsiveness 
xset r rate 180                                           
xset mouse 22/7 1                                         
                                                          
# Keyboard layouts                                        
# Switch layouts by pressing the capslock
setxkbmap \
    -layout us,il,ru \
    -variant dvorak,,winkeys \
    -option \
    -option grp:caps_toggle \
    -option grp_led:scroll \
    -option compose:rctrl \
    -option lv3:ralt_switch \
    -option terminate:ctrl_alt_bkspc

# Urxvt daemon, for faster urxvt   
urxvtd -q -o -f
#!/usr/bin/env sh

# Tmux sessions
tmux new -d -s irc weechat-curses
tmux new -d -s music ncmpcpp
tmux new -d -s dev

# Start the deluge daemon
deluged -p 58846

# Also start the web interface
deluge-web -p 8112 -f

# Automatically loads the last wallpaper that was set up with feh
sh ~/.fehbg

# Use xbindkeys for all the hotkeys that don't require to be set up with a WM
# like applications and other things (check ~/.xbindkeysrc for the full list)
xbindkeys

# Cursor theme (requires xcursor-neutral)
xsetroot -cursor_name Neutral

# Merge the custom Xresources settings with the default ones
xrdb -merge ~/.Xresources

# WM
exec xmonad
