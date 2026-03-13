# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# FZF - Fuzzy finder
if status is-interactive
    if type -q fzf
        fzf --fish | source

        set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
        set -x FZF_DEFAULT_OPTS "--layout=reverse --border --info=inline --height=80%"

        set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -x FZF_CTRL_T_OPTS "--preview 'bat --line-range :500 {}'"

        set -x FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'
        set -x FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"

        set -x FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:wrap"

        function frg
            rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/*' $argv | fzf \
                --ansi \
                --delimiter : \
                --preview 'bat --highlight-line {2} {1}' \
                --preview-window 'right:60%:wrap' \
                --bind 'enter:execute(nvim +{2} {1})'
        end
    end
end
