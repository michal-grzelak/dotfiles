# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Securely load all .sh files from conf.d and subdirectories in sorted order
# Only source files owned by the current user for security

_confd_dir="$HOME/.config/bash/conf.d"

if [[ -d "$_confd_dir" ]]; then
    _owned_files=()
    while IFS= read -r -d '' _file; do
        if [[ -O "$_file" ]]; then
            _owned_files+=("$_file")
        fi
    done < <(find "$_confd_dir" -type f -name '*.sh' -print0)

    _sorted_files=()
    while IFS= read -r -d '' _file; do
        _sorted_files+=("$_file")
    done < <(printf '%s\0' "${_owned_files[@]}" | sort -z)

    for _file in "${_sorted_files[@]}"; do
        source "$_file"
    done

    unset _confd_dir _owned_files _sorted_files _file
fi
