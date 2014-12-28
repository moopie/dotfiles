DOTFILES := $(shell pwd)

all: locals xorg _xmonad vimperator bin headless

headless: locals _bin _zsh _vim tmux git rtorrent weechat update

locals:
	mkdir -p ${HOME}/.local
	mkdir -p ${HOME}/.config
	ln -fs $(DOTFILES)/profile ${HOME}/.profile
_bin:
	ln -fsn $(DOTFILES)/bin ${HOME}/.local/bin
xorg:
	ln -fs $(DOTFILES)/xresources ${HOME}/.Xresources
	ln -fs $(DOTFILES)/xbindkeysrc ${HOME}/.xbindkeysrc
	ln -fs $(DOTFILES)/xmodmap ${HOME}/.xmodmap
	ln -fs $(DOTFILES)/gmrunrc ${HOME}/.gmrunrc
	ln -fsn $(DOTFILES)/ncmpcpp ${HOME}/.ncmpcpp
	ln -fs $(DOTFILES)/xprofile ${HOME}/.xprofile
	ln -fsn $(DOTFILES)/urxvt ${HOME}/.urxvt
	ln -fsn $(DOTFILES)/zathurarc ${HOME}/.zathurarc
_xmonad:
	ln -fsn $(DOTFILES)/xmonad ${HOME}/.xmonad
	ln -fsn $(DOTFILES)/xmobarrc ${HOME}/.xmobarrc
rtorrent:
	mkdir -p ${HOME}/.rtorrent/sessions
	mkdir -p ${HOME}/Torrents
	ln -fsn $(DOTFILES)/rtorrent.rc ${HOME}/.rtorrent.rc
_zsh:
	ln -fsn $(DOTFILES)/zsh/oh-my-zsh ${HOME}/.config/oh-my-zsh
	ln -fs $(DOTFILES)/zsh/zshrc ${HOME}/.zshrc
_vim:
	ln -fsn $(DOTFILES)/vim ${HOME}/.vim
	mkdir -p ${HOME}/.vim/tmp
	mkdir -p ${HOME}/.vim/backup
	ln -fs $(DOTFILES)/vim/vimrc ${HOME}/.vimrc
	ln -fs $(DOTFILES)/jshintrc ${HOME}/.jshintrc
tmux:
	ln -fs $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vimperator:
	ln -fs $(DOTFILES)/vimperatorrc ${HOME}/.vimperatorrc
git:
	ln -fs $(DOTFILES)/gitconfig ${HOME}/.gitconfig
weechat:
	mkdir -p ${HOME}/.weechat
	ln -fs $(DOTFILES)/weechat/weechat.conf ${HOME}/.weechat/weechat.conf
update:
	git submodule init
	git submodule update --recursive
