# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Securely load all .sh files from conf.d and subdirectories in sorted order
# Only source files owned by the current user for security

_confd_dir="./conf.d"
_current_uid=$(id -u)

if [[ -d "$_confd_dir" ]]; then
    # Find all .sh files recursively and sort them
    while IFS= read -r -d '' _conf_file; do
        # Security check: verify file is owned by current user
        _file_owner=$(stat -c %u "$_conf_file" 2>/dev/null)
        if [[ "$_file_owner" != "$_current_uid" ]]; then
            continue
        fi

        source "$_conf_file"
    done < <(find "$_confd_dir" -type f -name '*.sh' -print0 | sort -z)
    unset _confd_dir _current_uid _conf_file _file_owner
fi
