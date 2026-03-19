# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Zoxide - Smarter cd command
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"

    alias cd="z"
fi
