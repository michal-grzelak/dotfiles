# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Mise - Dev tool version manager
if type -q mise
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end
end
