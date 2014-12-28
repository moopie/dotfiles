DOTFILES := $(shell pwd)
LN = ln -fs
LNF = ln -fsn # for folders
MKDIR = mkdir -p

all: locals xorg _xmonad vimperator bin rtorrent headless

headless: locals _bin _zsh _vim tmux git weechat update

locals:
	$(MKDIR) ${HOME}/.local
	$(MKDIR) ${HOME}/.config
	$(LN) $(DOTFILES)/profile ${HOME}/.profile
_bin:
	$(LNF) $(DOTFILES)/bin ${HOME}/.local/bin
xorg:
	$(LN) $(DOTFILES)/xresources ${HOME}/.Xresources
	$(LN) $(DOTFILES)/xbindkeysrc ${HOME}/.xbindkeysrc
	$(LN) $(DOTFILES)/xmodmap ${HOME}/.xmodmap
	$(LN) $(DOTFILES)/gmrunrc ${HOME}/.gmrunrc
	$(LNF) $(DOTFILES)/ncmpcpp ${HOME}/.ncmpcpp
	$(LN) $(DOTFILES)/xprofile ${HOME}/.xprofile
	$(LNF) $(DOTFILES)/urxvt ${HOME}/.urxvt
	$(LNF) $(DOTFILES)/zathurarc ${HOME}/.zathurarc
_xmonad:
	$(LNF) $(DOTFILES)/xmonad ${HOME}/.xmonad
	$(LNF) $(DOTFILES)/xmobarrc ${HOME}/.xmobarrc
rtorrent:
	$(MKDIR) ${HOME}/.rtorrent/sessions
	$(MKDIR) ${HOME}/Torrents
	$(LNF) $(DOTFILES)/rtorrent.rc ${HOME}/.rtorrent.rc
_zsh:
	$(LNF) $(DOTFILES)/zsh/oh-my-zsh ${HOME}/.config/oh-my-zsh
	$(LN) $(DOTFILES)/zsh/zshrc ${HOME}/.zshrc
_vim:
	$(LNF) $(DOTFILES)/vim ${HOME}/.vim
	$(LN) $(DOTFILES)/vim/vimrc ${HOME}/.vimrc
	$(LN) $(DOTFILES)/jshintrc ${HOME}/.jshintrc
tmux:
	$(LN) $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vimperator:
	$(LN) $(DOTFILES)/vimperatorrc ${HOME}/.vimperatorrc
git:
	$(LN) $(DOTFILES)/gitconfig ${HOME}/.gitconfig
weechat:
	$(MKDIR) ${HOME}/.weechat
	$(LN) $(DOTFILES)/weechat/weechat.conf ${HOME}/.weechat/weechat.conf
update:
	git submodule init
	git submodule update --recursive
