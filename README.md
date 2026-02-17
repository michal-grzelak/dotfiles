# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/), migrated from a Nix-based configuration.

## Quick Start

### One-line Install

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/michal-grzelak/dotfiles.git
```

### Manual Install

```bash
# Install chezmoi
brew install chezmoi  # macOS
# or
sudo apt install chezmoi  # Debian/Ubuntu

# Initialize with this repository
chezmoi init https://github.com/michal-grzelak/dotfiles.git

# Preview changes
chezmoi diff

# Apply changes
chezmoi apply
```

## Features

- **Cross-platform**: Works on macOS, Linux, and WSL
- **Extensible**: Uses `modify_` scripts to preserve user additions
- **Modular**: Organized config files for each tool
- **External resources**: Plugins fetched via `.chezmoiexternal.toml`

## Managed Configurations

| Tool | Config Location | Notes |
|------|-----------------|-------|
| Git | `~/.gitconfig` | Template with OS-specific settings |
| Fish | `~/.config/fish/` | Template for machine-specific aliases |
| Starship | `~/.config/starship.toml` | Prompt configuration |
| Tmux | `~/.config/tmux/` | With TPM plugin manager |
| Neovim | `~/.config/nvim/` | LazyVim-based configuration |
| Bat | `~/.config/bat/` | Cat clone with syntax highlighting |
| Eza | `~/.config/eza/` | Modern ls replacement |
| FZF | `~/.config/fzf/` | Fuzzy finder configuration |
| SSH | `~/.ssh/config` | Uses modify_ for user additions |
| GitHub CLI | `~/.config/gh/` | gh configuration |
| Mise | `~/.config/mise/` | Runtime version manager |
| Ripgrep | `~/.config/ripgrep/` | Search tool configuration |
| Lazygit | `~/.config/lazygit/` | Git TUI configuration |

## Extending Configurations

### Adding Personal Config Without Modifying Repo

1. **Using `modify_` scripts** (SSH, Git):
   - Your additions are preserved after the managed sections
   - Edit the target file directly, chezmoi will preserve additions

2. **Using local config files**:
   - Fish: Create `~/.config/fish/config.local.fish`
   - Git: Create `~/.config/git/config.local`
   - These are automatically included if they exist

3. **Template variables**:
   - Override in `~/.config/chezmoi/chezmoi.toml`:
   ```toml
   [data]
       email = "your@email.com"
       name = "Your Name"
       [data.git]
           signingKey = "YOUR-KEY"
   ```

## Directory Structure

```
dotfiles/
├── AGENTS.md              # Reference guide (not copied to system)
├── README.md              # This file
├── .gitignore
├── home/                  # Chezmoi source directory
│   ├── .chezmoi.toml.tmpl # Chezmoi config template
│   ├── .chezmoiexternal.toml  # External resources
│   ├── .chezmoiignore     # Files to ignore
│   ├── .chezmoidata/      # Data files for templates
│   │   └── packages.yaml  # Package lists
│   ├── dot_gitconfig.tmpl # Git config template
│   ├── dot_gitignore      # Global gitignore
│   ├── dot_config/        # XDG config files
│   ├── private_dot_ssh/   # SSH config (600 permissions)
│   ├── run_once_bootstrap.sh       # One-time setup
│   └── run_onchange_install-packages.sh.tmpl  # Package install
```

## Daily Operations

```bash
# Add a new config file
chezmoi add ~/.config/new-app/config

# Edit a managed file (opens source file)
chezmoi edit ~/.gitconfig

# Preview changes
chezmoi diff

# Apply changes
chezmoi apply

# Update from remote and apply
chezmoi update

# Run package installation
chezmoi run run_onchange_install-packages.sh
```

## Post-Install Steps

After applying dotfiles:

1. **Install tmux plugins**:
   ```bash
   ~/.config/tmux/plugins/tpm/bin/install_plugins
   ```

2. **Install neovim plugins**:
   ```bash
   nvim --headless '+Lazy! sync' +qa
   ```

3. **Set fish as default shell** (optional):
   ```bash
   chsh -s $(which fish)
   ```

4. **Configure mise tools** (optional):
   ```bash
   mise install
   ```

## Reference

See [AGENTS.md](AGENTS.md) for:
- Detailed patterns and recipes
- Common troubleshooting
- Chezmoi command reference
- Extending configurations

## License

Apache-2.0