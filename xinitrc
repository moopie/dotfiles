#!/bin/sh

execdir () {
    if [ -d "$1" ]; then
        for f in "$1"/*; do
            [ -x "$f" ] && . "$f"
        done
        unset f
    fi
}

execdir /etc/X11/xinit/xinitrc.d 
execdir $HOME/.config/xinit.d
