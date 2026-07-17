export GOPATH="$HOME/go"

export PATH="\
${HOME}/bin:\
${GOPATH}/bin:\
/usr/local/bin:\
/opt/homebrew/opt/openjdk/bin:\
/opt/homebrew/opt/dotnet@6/bin:\
${HOME}/.cargo/bin:\
${HOME}/.dotnet/tools:\
${HOME}/.aspire/bin:\
${DOTNET_ROOT}:\
${HOME}/.local/bin/omnisharp-lsp:\
${PATH}"

export MANPATH="/usr/local/man:${MANPATH:-}"
export LANG="en_US.UTF-8"

export EDITOR="emacsclient"
export VISUAL="emacsclient -t -a ''"

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

git_prompt_branch() {

    local branch dirty

    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||

        branch=$(git rev-parse --short HEAD 2>/dev/null) ||

        return

    if ! git diff --quiet --ignore-submodules HEAD 2>/dev/null ||
       ! git diff --cached --quiet --ignore-submodules 2>/dev/null; then

        dirty='*'

    fi

    printf ' (%s%s)' "$branch" "$dirty"

}

if [[ -t 1 ]]; then
    PS1='\[\e[1;32m\]\u@\h\[\e[0m\] '
    PS1+='\[\e[1;34m\]\W\[\e[0m\]'
    PS1+='\[\e[1;31m\]$(git_prompt_branch)\[\e[0m\] '
    PS1+='\$ '
else
    PS1='\u@\h \W \$ '
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
alias ls='ls --color=auto'
alias ll='ls -lh'
alias l='ls -CF'
alias la='ls -A'
alias grep='grep --color=auto -i'

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
alias ec="emacsclient -t -a ''"

# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------

alias lg='lazygit'

alias g='git'
alias ga='git add'
alias gs='git s'
alias gst='git st'
alias gsh='git show'
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

alias p='podman'
alias pc='podman-compose'
alias c='podman-compose'
alias clg='podman-compose logs -f --tail 50'
alias clogs='podman-compose logs -f'

alias k='kubectl'
alias kns='kubens'
alias ktx='kubectx'

# ---------------------------------------------------------------------------
# Other programs
# ---------------------------------------------------------------------------

alias nm='neomutt'
alias y='yazi'

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

# ---------------------------------------------------------------------------
# Bash completion
# ---------------------------------------------------------------------------

# Homebrew's bash-completion package.
#
# Install with:
#   brew install bash-completion@2
#
if [[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
    source /opt/homebrew/etc/profile.d/bash_completion.sh
elif [[ -r /usr/local/etc/profile.d/bash_completion.sh ]]; then
    source /usr/local/etc/profile.d/bash_completion.sh
elif [[ -r /usr/local/etc/bash_completion ]]; then
    source /usr/local/etc/bash_completion
fi

# ---------------------------------------------------------------------------
# Replace bash history (Ctrl-R) with fzf
# ---------------------------------------------------------------------------
if [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.bash" ]]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.bash"
fi

if [[ -f "$(brew --prefix)/opt/fzf/shell/completion.bash" ]]; then
    source "$(brew --prefix)/opt/fzf/shell/completion.bash"
fi
