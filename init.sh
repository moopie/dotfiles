#!/bin/bash

DIR = $(PWD)

ln -s $DIR/Xdefaults ~/.Xdefaults
ln -s $DIR/irssi ~/.irssi
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/xinitrc ~/.xinitrc
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/.config/awesome $XDG_CONFIG_HOME/awesome
ln -s $DIR/.config/fontconfig $XDG_CONFIG_HOME/fontconfig
ln -s $DIR/.config/zsh $XDG_CONFIG_HOME/zsh
