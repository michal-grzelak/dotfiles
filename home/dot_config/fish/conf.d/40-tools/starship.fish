# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Starship prompt
if status is-interactive
    if type -q starship
        starship init fish | source
    end
end
