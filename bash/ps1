#!/usr/bin/env bash

# wrap in a function to allow local variables
set_ps1() {

    # Reset
    local CReset="\[\033[0m\]" # Text Reset

    # Regular Colors
    local Black="\[\033[0;30m\]"  # Black
    local Red="\[\033[0;31m\]"    # Red
    local Green="\[\033[0;32m\]"  # Green
    local Yellow="\[\033[0;33m\]" # Yellow
    local Blue="\[\033[0;34m\]"   # Blue
    local Purple="\[\033[0;35m\]" # Purple
    local Cyan="\[\033[0;36m\]"   # Cyan
    local White="\[\033[0;37m\]"  # White

    if [ -e /usr/share/git/completion/git-prompt.sh ]; then
        source /usr/share/git/completion/git-prompt.sh
    fi

    local user=$(whoami)
    if [ $user = 'root' ]; then
        user_color="$Red"
    else
        user_color="$Green"
    fi

    PS1=""
    PS1="$PS1$user_color\u@\h " # username@host
    PS1="$PS1$Cyan\w"           # Path

    # Debian-specific chroot variable
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi
    if [ ! -z "$debian_chroot" ]; then
        PS1="${debian_chroot:+($debian_chroot)} $PS1"
    fi

    # Bash prompt
    if command -v __git_ps1 >/dev/null 2>&1; then
        GIT_PS1_SHOWDIRTYSTATE=true
        GIT_PS1_SHOWUNTRACKEDFILES=true
        GIT_PS1_SHOWUPSTREAM="auto"
        GIT_PS1_SHOWCOLORHINTS=true
        PS1="$PS1$Yellow"
        PS1="$PS1"'$(__git_ps1 " (%s)")'
    fi

    PS1="$PS1$CReset"
    PS1="$PS1\n"
    PS1="$PS1\$ "

    export PS1
}

set_ps1
