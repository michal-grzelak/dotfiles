# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# FZF - Fuzzy finder
if command -v fzf &> /dev/null; then
    eval "$(fzf --bash)"

    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
    export FZF_DEFAULT_OPTS="--layout=reverse --border --info=inline --height=80%"

    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--preview 'bat --line-range :500 {}'"

    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap"

    frg() {
        rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/*' "$@" | fzf \
            --ansi \
            --delimiter : \
            --preview 'bat --highlight-line {2} {1}' \
            --preview-window 'right:60%:wrap' \
            --bind 'enter:execute(nvim +{2} {1})'
    }
fi
