# Common configuration

# Disable greeting
set -g fish_greeting ""

# Editor settings
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER delta

# XDG directories
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/.cache

# mise override
set -gx MISE_FISH_AUTO_ACTIVATE 0
