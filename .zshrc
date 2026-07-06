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
	fzf
	)

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR="nvim"

export PATH="\
/opt/homebrew/opt/openjdk/bin:\
/opt/homebrew/opt/dotnet@6/bin:\
${HOME}/.cargo/bin:\
${HOME}/.dotnet/tools:\
$PATH"

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESS_TERMCAP_ue=$'\e[0m'

export MANPAGER="less -R"

# Dev


# Aliases
alias ohmyzsh="$EDITOR $ZSH"
alias omzupdate="cd $ZSH && git pull && cd -"

alias py="python3"
alias py2="python2"
alias py3="python3"

alias v="nvim"
alias nv="nvim"

alias e="emacs"
alias ec="emacsclient"

alias lg="lazygit"
alias g="git"
alias ga="git add"
alias gs="git s"
alias gst="git st"
alias gp="git push"
alias gu="git pull"
alias gd="git diff"
alias gb="git branch"
alias gt="git tag"
alias gl="git lg"
alias gf="git fetch"
alias gm="git merge"
alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gco="git checkout"

alias p="podman"
alias pc="podman-compose"
alias c="podman-compose"
alias d="docker"
alias dc="docker compose"
alias k="kubectl"
alias kns="kubens"
alias ktx="kubectx"

alias nm="neomutt"

fdf() {
    local selected

    selected=$(
        fd "$@" |
        fzf \
            --height=50% \
            --preview '
                if [[ -d {} ]]; then
                    tree -C {} | head -100
                else
                    bat --style=numbers --color=always {}
                fi
            '
    ) || return

    if [[ -d "$selected" ]]; then
        cd "$selected"
    else
        nvim "$selected"
    fi
}

export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
export PATH="$DOTNET_ROOT:$PATH"/.local/bin/omnisharp-lsp:$PATH"

# Load Angular CLI autocompletion.
source <(ng completion script)

# Added by get-aspire-cli.sh
export PATH="$HOME/.aspire/bin:$PATH"
export PATH="$HOME# Use the brew dotnet
