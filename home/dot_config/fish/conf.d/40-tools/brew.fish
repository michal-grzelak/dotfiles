# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Homebrew shell integration
set -l brew_path ""
for path in /home/linuxbrew/.linuxbrew/bin/brew ~/.linuxbrew/bin/brew /usr/local/bin/brew /opt/homebrew/bin/brew
    if test -x "$path"
        set brew_path $path
        break
    end
end

if test -n "$brew_path"
    $brew_path shellenv fish | source

    set -gx HOMEBREW_NO_ANALYTICS 1
    set -gx HOMEBREW_NO_INSTALL_CLEANUP 0
    set -gx HOMEBREW_BUNDLE_FILE "$HOME/.Brewfile"

    if test -d "$HOMEBREW_PREFIX/share/fish/completions"
        set -p fish_complete_path "$HOMEBREW_PREFIX/share/fish/completions"
    end
    if test -d "$HOMEBREW_PREFIX/share/fish/vendor_completions.d"
        set -p fish_complete_path "$HOMEBREW_PREFIX/share/fish/vendor_completions.d"
    end
end
