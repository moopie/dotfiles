#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500
HISTFILESIZE=10000

# always limit man to 80 characters wide
export MANWIDTH=80

# less options
# check to make sure we don't override system-set $LESS
[ -z "$LESS" ] && export LESS
LESS="$LESS -R"  # parse ANSI codes, git requires this
LESS="$LESS -i"  # smart case search

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# automatically change dirs
shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
for f in \
    /usr/bin/lesspipe \
    /usr/bin/lesspipe.sh \
; do
    if [ -x "$f" ]; then
        eval "$(SHELL=/bin/sh $f)"
    fi
done

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_alias ]; then
    source ~/.bash_alias
fi

# PS1 config
if [ -f ~/.bash_ps1 ]; then
    source ~/.bash_ps1
fi

export EDITOR=code
export PAGER=less

