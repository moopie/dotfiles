DOTFILES := $(shell pwd)

all: headless xorg _xmonad vimperator update

headless: locals shell editor tmux git rtorrent

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
	ln -fs $(DOTFILES)/bash/inputrc ${HOME}/.inputrc
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
root:
	cp $(DOTFILES)/bash/bashrc /root/.bashrc
	cp $(DOTFILES)/bash/alias /root/.bash_alias
	cp $(DOTFILES)/bash/ps1 /root/.bash_ps1
	cp $(DOTFILES)/bash/inputrc /root/.inputrc
update:
	git submodule init
	git submodule update --recursive
