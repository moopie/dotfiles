DOTFILES := $(shell pwd)

all: headless xorg _xmonad vimperator

headless: locals shell editor tmux git rtorrent update

locals:
	mkdir -p ${HOME}/.local
	mkdir -p ${HOME}/.config
xorg:
	ln -fs $(DOTFILES)/xresources ${HOME}/.Xresources
	ln -fs $(DOTFILES)/xmodmap ${HOME}/.xmodmap
	ln -fs $(DOTFILES)/xprofile ${HOME}/.xprofile
	ln -fsn $(DOTFILES)/urxvt ${HOME}/.urxvt
_xmonad:
	ln -fsn $(DOTFILES)/xmonad ${HOME}/.xmonad
	ln -fsn $(DOTFILES)/xmobarrc ${HOME}/.xmobarrc
rtorrent:
	mkdir -p ${HOME}/.rtorrent/sessions
	mkdir -p ${HOME}/Torrents
	ln -fsn $(DOTFILES)/rtorrent.rc ${HOME}/.rtorrent.rc
shell:
	ln -fs $(DOTFILES)/bash/bashrc ${HOME}/.bashrc
	ln -fs $(DOTFILES)/bash/alias ${HOME}/.bash_alias
	ln -fs $(DOTFILES)/bash/ps1 ${HOME}/.bash_ps1
editor:
	ln -fsn $(DOTFILES)/vim ${HOME}/.vim
	ln -fs $(DOTFILES)/vim/vimrc ${HOME}/.vimrc
tmux:
	ln -fs $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vimperator:
	ln -fs $(DOTFILES)/vimperatorrc ${HOME}/.vimperatorrc
git:
	ln -fs $(DOTFILES)/gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/gitignore_global ${HOME}/.gitignore_global
update:
	git submodule init
	git submodule update --recursive
