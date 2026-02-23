# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Bat config path
set -gx BAT_CONFIG_PATH $XDG_CONFIG_HOME/bat/config.conf

# Bat alias (cat replacement)
alias cat='bat --paging=never'
