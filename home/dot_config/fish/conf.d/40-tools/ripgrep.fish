# MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit

# Ripgrep - Fast grep
alias rg='rg --smart-case --hidden'

# Interactive search with fzf
function rgf
    set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case"
    set -gx FZF_DEFAULT_COMMAND "$RG_PREFIX ''"
    fzf --bind="change:reload:$RG_PREFIX {q} || true" --ansi --phony --query ""
end
