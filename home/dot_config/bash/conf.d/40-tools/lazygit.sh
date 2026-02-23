# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# LazyGit - Simple git UI
lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
    command lazygit "$@"
    if [[ -f "$LAZYGIT_NEW_DIR_FILE" ]]; then
        cd "$(cat "$LAZYGIT_NEW_DIR_FILE")" && rm -f "$LAZYGIT_NEW_DIR_FILE"
    fi
}
