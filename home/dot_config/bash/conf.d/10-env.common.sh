# Common configuration

# Only run for interactive shells
[[ $- != *i* ]] && return

# XDG Base Directory specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# History settings
HISTFILESIZE=100000
HISTSIZE=10000
HISTCONTROL=ignoredups:erasedups
HISTIGNORE="ls:cd:exit"
PROMPT_COMMAND="history -a; history -n"
shopt -s histappend
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

# Editor settings
export EDITOR=nvim
export VISUAL=nvim
export PAGER=delta

# System bash completion
if [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
elif [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi
