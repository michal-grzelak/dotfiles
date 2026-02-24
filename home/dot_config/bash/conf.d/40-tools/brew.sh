# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Homebrew shell integration
brew_path=""
for path in /home/linuxbrew/.linuxbrew/bin/brew ~/.linuxbrew/bin/brew /usr/local/bin/brew /opt/homebrew/bin/brew; do
    if [[ -x "$path" ]]; then
        brew_path="$path"
        break
    fi
done

if [[ -n "$brew_path" ]]; then
    eval "$($brew_path shellenv bash)"

    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSTALL_CLEANUP=0
    export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile"

    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
            [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
        done
    fi
fi
