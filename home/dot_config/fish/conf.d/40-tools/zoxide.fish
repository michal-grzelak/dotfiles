# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Zoxide - Smarter cd command
if status is-interactive
    if type -q zoxide
        zoxide init fish | source

        alias cd z
    end
end
