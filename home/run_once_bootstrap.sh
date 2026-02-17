#!/usr/bin/env bash

# Bootstrap script - runs once on first setup

set -e

echo "=== Bootstrap Script ==="

# Create essential directories
echo "Creating directories..."
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/projects"

# Set up fish as default shell if available
if command -v fish >/dev/null 2>&1; then
    current_shell=$(basename "$SHELL")
    if [ "$current_shell" != "fish" ]; then
        echo "Fish shell available. To set as default shell, run:"
        echo "  chsh -s \$(which fish)"
    fi
fi

# Check for essential tools and suggest installation
echo ""
echo "Checking for essential tools..."

missing_tools=""

for tool in git nvim tmux fish starship zoxide fzf eza bat ripgrep fd mise gh; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        missing_tools="$missing_tools $tool"
    fi
done

if [ -n "$missing_tools" ]; then
    echo "Missing tools:$missing_tools"
    echo ""
    echo "To install missing tools, run the package installation script:"
    echo "  chezmoi run run_onchange_install-packages.sh"
else
    echo "All essential tools are installed!"
fi

echo ""
echo "=== Bootstrap Complete ==="
echo "Next steps:"
echo "1. Run 'chezmoi apply' to apply all configurations"
echo "2. Install TPM for tmux: ~/.config/tmux/plugins/tpm/bin/install_plugins"
echo "3. Restart your shell or run: exec fish"
