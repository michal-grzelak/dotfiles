# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi
