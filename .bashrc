export GOPATH="$HOME/go"
export DOTNET_ROOT="/opt/homebrew/Cellar/dotnet/10.0.400/libexec"

export PATH="\
${HOME}/bin:\
${GOPATH}/bin:\
/usr/local/bin:\
${HOME}/.cargo/bin:\
${HOME}/.dotnet/tools:\
${HOME}/.aspire/bin:\
${DOTNET_ROOT}:\
${HOME}/.local/bin/omnisharp-lsp:\
${PATH}"

export MANPATH="/usr/local/man:${MANPATH:-}"
export LANG="en_US.UTF-8"

export EDITOR="nvim"
export VISUAL="nvim"

# ---------------------------------------------------------------------------
# less and man
# ---------------------------------------------------------------------------

export LESS_TERMCAP_mb=$'\e[5;31m'      # blinking
export LESS_TERMCAP_md=$'\e[1;36m'      # bold
export LESS_TERMCAP_me=$'\e[0m'         # reset
export LESS_TERMCAP_mr=$'\e[7m'         # reverse
export LESS_TERMCAP_mh=$'\e[2m'         # dim
export LESS_TERMCAP_mp=$'\e[0m'         # reset protected
export LESS_TERMCAP_so=$'\e[1;33;44m'   # standout
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'      # underline
export LESS_TERMCAP_ue=$'\e[0m'

export MANPAGER="less -R"

# ---------------------------------------------------------------------------
# Bash history
# ---------------------------------------------------------------------------

# Append history instead of overwriting it when Bash exits.
shopt -s histappend

# Save multiline commands as one history entry.
shopt -s cmdhist

# Update terminal dimensions after each command.
shopt -s checkwinsize

# Automatically cd
shopt -s autocd

# Ignore duplicate commands and commands beginning with a space.
export HISTCONTROL="ignoreboth:erasedups"

export HISTSIZE=10000
export HISTFILESIZE=20000

# ---------------------------------------------------------------------------
# Prompt
#
# Similar idea to the robbyrussell prompt:
#   user@host current-directory git-branch
# ---------------------------------------------------------------------------

errcode_prompt() {
    local errcode=$?
    local red bold reset

    red=$(tput setaf 1)
    bold=$(tput bold)
    reset=$(tput sgr0)

    if ((errcode != 0)); then
        printf '%s%s[%s]%s' "$bold" "$red" "$errcode" "$reset"
    fi
}

git_prompt_branch() {
    local branch dirty

    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
        branch=$(git rev-parse --short HEAD 2>/dev/null) ||
        return

    # Check for staged or unstaged changes.
    if ! git diff --quiet --ignore-submodules HEAD 2>/dev/null ||
       ! git diff --cached --quiet --ignore-submodules 2>/dev/null; then
        dirty='*'
    fi

    printf ' (%s%s)' "$branch" "$dirty"
}

if [[ -t 1 ]]; then
    PS1='$(errcode_prompt)'
    PS1+='\[\e[1;32m\]\u@\h\[\e[0m\]:'
    PS1+='\[\e[1;34m\]\w\[\e[0m\]'
    PS1+='\[\e[1;31m\]$(git_prompt_branch)\[\e[0m\] '
    PS1+='\n'
    PS1+='\$ '
fi

# ---------------------------------------------------------------------------
# Directory aliases
# ---------------------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ---------------------------------------------------------------------------
# General linux utilities
# ---------------------------------------------------------------------------
alias ls='ls --color=always'
alias ll='ls -l'
alias lt='ls -ltr'
alias l='ls'
alias la='ls -la'
alias grep='grep --color=always'
alias dt='date +%Y-%m-%dT%H:%M:%S%z'
alias less='less -R'

# ---------------------------------------------------------------------------
# Python
# ---------------------------------------------------------------------------

alias py='python3'
alias py2='python2'
alias py3='python3'

# ---------------------------------------------------------------------------
# Editors
# ---------------------------------------------------------------------------

alias v='nvim'
alias nv='nvim'

alias e='emacs'
alias ec="emacsclient -a ''"

# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------

alias lg='lazygit'

alias g='git'
alias ga='git add'
alias gs='git s'
alias gst='git st'
alias gsh='git show'
alias gg='git grep'
alias gp='git push'
alias gu='git pull'
alias gd='git diff'
alias gb='git branch'
alias gt='git tag'
alias gl='git lg'
alias gf='git fetch'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gco='git checkout'

# ---------------------------------------------------------------------------
# Package managers
# ---------------------------------------------------------------------------

# Arch Linux / AUR
alias t='trizen'
alias tup='trizen -Syu --noedit --noconfirm'

# Homebrew
alias b='brew'
alias bup='brew upgrade'

# ---------------------------------------------------------------------------
# Containers and Kubernetes
# ---------------------------------------------------------------------------

alias d='docker'
alias dc='docker compose'

alias docker='podman'
alias docker-compose='podman-compose'
alias d='docker'
alias dc='docker-compose'
alias c='docker-compose'
alias clg='docker-compose logs -f --tail 50'
alias clogs='docker-compose logs -f'

alias k='kubectl'
alias kns='kubens'
alias ktx='kubectx'

# ---------------------------------------------------------------------------
# Other programs
# ---------------------------------------------------------------------------

alias nm='neomutt'
alias y='yazi'
alias gclear='clear;greet'

# startup messages

greet() {
    local bold reset green red

    bold=$(tput bold)
    reset=$(tput sgr0)
    green=$(tput setaf 2)   # Green
    red=$(tput setaf 9)

    figlet "$(hostname -s)"
    uname -a
    uptime
    echo

    echo "user  ${bold}${green}$(whoami)${reset}"
    echo "host  ${bold}${green}$(hostname)${reset}"
    echo "date  ${bold}$(dt)${reset}"
    echo "shell ${green}$BASH${reset} ${red}${bold}$BASH_VERSION${reset}"
    echo

    cal

    fortune | cowsay -r

    echo
}

