# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Securely load all .sh files from conf.d in sorted order
# Only source files owned by the current user for security

_confd_dir="$HOME/.config/bash/conf.d"

if [[ -d "$_confd_dir" ]]; then
    for _file in "$_confd_dir"/*.sh; do
        [[ -f "$_file" && -O "$_file" ]] && source "$_file"
    done
    unset _confd_dir _file
fi
