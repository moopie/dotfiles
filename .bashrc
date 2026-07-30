export GOPATH="$HOME/go"

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
    local red reset

    red=$(tput setaf 1)
    reset=$(tput sgr0)

    if (($errcode != 0)); then
        printf '%s[%s]%s' "$red" "$errcode" "$reset"
    fi
}

git_prompt_branch() {
    local branch dirty ahead

    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
        branch=$(git rev-parse --short HEAD 2>/dev/null) ||
        return

    if ! git diff --quiet --ignore-submodules HEAD 2>/dev/null ||
       ! git diff --cached --quiet --ignore-submodules 2>/dev/null; then
        dirty='?'
    fi

    if git rev-parse --verify '@{u}' >/dev/null 2>&1; then
        if [[ $(git rev-list --count '@{u}..HEAD') -gt 0 ]]; then
            ahead='+'
        fi
    fi

    printf ' (%s%s%s)' "$branch" "$dirty" "$ahead"
}

if [[ -t 1 ]]; then
    PS1='$(errcode_prompt)'
    #PS1+='\[\e[1;32m\]\u@\h\[\e[0m\] '
    PS1+='\[\e[1;34m\]\w\[\e[0m\]'
    PS1+='\[\e[1;31m\]$(git_prompt_branch)\[\e[0m\] '
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
alias ls='ls --color=always -F'
alias ll='ls -lF'
alias l='ls -F'
alias la='ls -laF'
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
alias ts='trizen -Ss'
alias ti='trizen -S'

# Homebrew
alias b='brew'
alias bup='brew upgrade'
alias bs='brew search'
alias bi='brew install'

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
alias clearg='clear;greet'

# startup messages

color_cal() {
    local today last_day color bold reset red green yellow

    today=$((10#$(date +%d)))
    last_day=$((10#$(cal | awk 'NF { last=$NF } END { print last }')))

    bold=$(tput bold)
    reset=$(tput sgr0)
    red="${bold}$(tput setaf 1)"
    green="${bold}$(tput setaf 2)"
    yellow="${bold}$(tput setaf 3)"

    if (( today > last_day - 7 )); then
        color=$red
    elif (( today * 2 >= last_day )); then
        color=$yellow
    else
        color=$green
    fi

    printf '%s' "$color"
    cal
    printf '%s' "$reset"
}

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

    color_cal

    fortune | cowsay -r

    echo
}

# ---------------------------------------------------------------------------
# fd + fzf file selector
# ---------------------------------------------------------------------------

fdf() {
    local selected

    selected=$(
        fd "$@" |
            fzf \
                --height=50% \
                --preview '
                    if [[ -d {} ]]; then
                        tree -C -- {} | head -100
                    else
                        bat --style=numbers --color=always -- {}
                    fi
                '
    ) || return

    if [[ -d "$selected" ]]; then
        cd -- "$selected" || return
    else
        "${EDITOR:-vi}" "$selected"
    fi
}

greet
