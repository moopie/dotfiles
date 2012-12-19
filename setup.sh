#!/usr/bin/env sh

conf = $XDG_CONFIG_HOME
dir = $PWD

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
ln -s $dir/zsh/themes/* zsh/oh-my-zsh/custom/
