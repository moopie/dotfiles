DOTFILES := $(shell pwd)
LN = ln -fs
LNF = ln -fsn # for folders
MKDIR = mkdir -p

all: dirs xorg _xmonad _zsh _vim tmux vimperator git _ranger rtorrent submodules

dirs:
	$(MKDIR) ${HOME}/.config
	$(MKDIR) ${HOME}/.local
	$(LNF) $(DOTFILES)/bin ${HOME}/.local/bin
xorg:
	$(LN) $(DOTFILES)/Xresources ${HOME}/.Xresources
	$(LN) $(DOTFILES)/xbindkeysrc ${HOME}/.xbindkeysrc
	$(LN) $(DOTFILES)/xinitrc ${HOME}/.xinitrc
	$(LN) $(DOTFILES)/gmrunrc ${HOME}/.gmrunrc
	$(LNF) $(DOTFILES)/ncmpcpp ${HOME}/.ncmpcpp
_xmonad:
	$(LNF) $(DOTFILES)/xmonad ${HOME}/.xmonad
_zsh:
	$(LNF) $(DOTFILES)/zsh/oh-my-zsh ${HOME}/.config/oh-my-zsh
	$(LN) $(DOTFILES)/zsh/zshrc ${HOME}/.zshrc
_vim:
	$(MKDIR) ${HOME}/.vim
	$(LNF) $(DOTFILES)/vim/bundle ${HOME}/.vim/bundle
	$(LN) $(DOTFILES)/vim/vimrc ${HOME}/.vimrc
tmux:
	$(LN) $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vimperator:
	$(LN) $(DOTFILES)/vimperatorrc ${HOME}/.vimperatorrc
git:
	$(LN) $(DOTFILES)/gitconfig ${HOME}/.gitconfig
_ranger:
	$(LNF) $(DOTFILES)/ranger ${HOME}/.config/ranger
rtorrent:
	$(MKDIR) ${HOME}/.rtorrent/session
	$(MKDIR) ${HOME}/Torrents
	$(MKDIR) ${HOME}/Downloads
	$(LN) $(DOTFILES)/rtorrent.rc ${HOME}/.rtorrent.rc
submodules:
	git submodule init
	git submodule update --recursive
