#!/usr/bin/env sh

conf = $XDG_CONFIG_HOME

ln -s awesome $conf/awesome
ln -s fontconfig $conf/fontconfig
ln -s zsh $conf/zsh

ln -s vim ~/.vim
ln -s irssi ~/.irssi

ln -s zsh/zshrc ~/.zshrc
ln -s vim/vimrc ~/.vimrc
ln -s xinitrc ~/.xinitrc
ln -s Xdefaults ~/.Xdefaults
ln -s gitconfig ~/.gitconfig

# Symlink all the custom themes
ln -s zsh/themes/* zsh/oh-my-zsh/custom/
