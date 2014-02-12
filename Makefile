DOTFILES := $(shell pwd)
LN = ln -fs
LNF = ln -fsn # for folders
MKDIR = mkdir -p

all: locals xorg _xmonad vimperator rtorrent bin headless

headless: locals _zsh _vim tmux git submodules

locals:
	$(MKDIR) ${HOME}/.local
bin:
	$(LNF) $(DOTFILES)/bin ${HOME}/.local/bin
xorg:
	$(LN) $(DOTFILES)/xresources ${HOME}/.Xresources
	$(LN) $(DOTFILES)/xbindkeysrc ${HOME}/.xbindkeysrc
	$(LN) $(DOTFILES)/gmrunrc ${HOME}/.gmrunrc
	$(LNF) $(DOTFILES)/ncmpcpp ${HOME}/.ncmpcpp
	$(LN) $(DOTFILES)/xinitrc ${HOME}/.xinitrc
	$(LNF) $(DOTFILES)/xinit.d ${HOME}/.config/xinit.d
_xmonad:
	$(LNF) $(DOTFILES)/xmonad ${HOME}/.xmonad
_zsh:
	$(MKDIR) ${HOME}/.config
	$(LNF) $(DOTFILES)/zsh/oh-my-zsh ${HOME}/.config/oh-my-zsh
	$(LN) $(DOTFILES)/zsh/zshrc ${HOME}/.zshrc
_vim:
	$(LNF) $(DOTFILES)/vim ${HOME}/.vim
	$(LN) $(DOTFILES)/vim/vimrc ${HOME}/.vimrc
tmux:
	$(LN) $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vimperator:
	$(LN) $(DOTFILES)/vimperatorrc ${HOME}/.vimperatorrc
git:
	$(LN) $(DOTFILES)/gitconfig ${HOME}/.gitconfig
rtorrent:
	$(MKDIR) ${HOME}/.rtorrent/session
	$(MKDIR) ${HOME}/Torrents
	$(MKDIR) ${HOME}/Downloads
	$(LN) $(DOTFILES)/rtorrent.rc ${HOME}/.rtorrent.rc
submodules:
	git submodule init
	git submodule update --recursive
