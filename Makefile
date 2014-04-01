DOTFILES := $(shell pwd)
LN = ln -fs
LNF = ln -fsn # for folders
MKDIR = mkdir -p

all: locals xorg _xmonad vimperator bin headless

headless: locals _zsh _vim tmux git update

locals:
	$(MKDIR) ${HOME}/.local
	$(MKDIR) ${HOME}/.config
	$(LN) $(DOTFILES)/profile ${HOME}/.profile
bin:
	$(LNF) $(DOTFILES)/bin ${HOME}/.local/bin
xorg:
	$(LN) $(DOTFILES)/xresources ${HOME}/.Xresources
	$(LN) $(DOTFILES)/xbindkeysrc ${HOME}/.xbindkeysrc
	$(LN) $(DOTFILES)/gmrunrc ${HOME}/.gmrunrc
	$(LNF) $(DOTFILES)/ncmpcpp ${HOME}/.ncmpcpp
	$(LN) $(DOTFILES)/xinitrc ${HOME}/.xinitrc
	$(LNF) $(DOTFILES)/xinitrc.d ${HOME}/.config/xinitrc.d
_xmonad:
	$(LNF) $(DOTFILES)/xmonad ${HOME}/.xmonad
_zsh:
	$(LNF) $(DOTFILES)/zsh/oh-my-zsh ${HOME}/.config/oh-my-zsh
	$(LN) $(DOTFILES)/zsh/zshrc ${HOME}/.zshrc
_vim:
	$(LNF) $(DOTFILES)/vim ${HOME}/.vim
	$(LN) $(DOTFILES)/vim/vimrc ${HOME}/.vimrc
	@echo nodejs dev
	$(LN) $(DOTFILES)/jshintrc ${HOME}/.jshintrc
tmux:
	$(LN) $(DOTFILES)/tmux.conf ${HOME}/.tmux.conf
vimperator:
	$(LN) $(DOTFILES)/vimperatorrc ${HOME}/.vimperatorrc
git:
	$(LN) $(DOTFILES)/gitconfig ${HOME}/.gitconfig
update:
	git submodule init
	git submodule update --recursive
