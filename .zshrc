# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/ohmyzsh"
export ZSHRC="~/.zshrc"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode disabled  # disable automatic updates

plugins=(
	git
	tmux
	brew
	kubectl
	docker
	podman
	kube-ps1
	)

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR="nvim"
export MANPAGER="most"
export PATH="$PATH:${HOME}/.dotnet/tools:/opt/homebrew/opt/dotnet@6/bin"

# Dev


# Aliases
alias ohmyzsh="$EDITOR $ZSH"
alias omzupdate="cd $ZSH && git pull && cd -"

alias r="ranger"

alias vi="nvim"
alias v="nvim"
alias nv="nvim"

alias g="git"
alias gcm="git commit -m"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gl="git lg"

alias p="podman"
alias pc="podman-compose"
alias c="podman-compose"
alias d="docker"
alias dc="docker compose"
alias k="kubectl"
alias kns="kubens"
alias ktx="kubectx"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"


# Load Angular CLI autocompletion.
source <(ng completion script)
