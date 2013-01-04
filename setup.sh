#!/usr/bin/env sh

# This script will probably horribly fail since T never actually tried to run it

conf = $XDG_CONFIG_HOME
dir = $(pwd)

ln -s $dir/awesome $conf/awesome
ln -s $dir/fontconfig $conf/fontconfig
ln -s $dir/zsh $conf/zsh

ln -s $dir/vim ~/.vim
ln -s $dir/irssi ~/.irssi
ln -s $dir/vimperator ~/.vimperator

ln -s $dir/vimperator/vimperatorrc ~/.vimperatorrc
ln -s $dir/zsh/zshrc ~/.zshrc
ln -s $dir/vim/vimrc ~/.vimrc
ln -s $dir/xinitrc ~/.xinitrc
ln -s $dir/Xdefaults ~/.Xdefaults
ln -s $dir/gitconfig ~/.gitconfig

# Symlink all the custom themes
ln -s $dir/zsh/themes/* $dir/zsh/oh-my-zsh/custom/
