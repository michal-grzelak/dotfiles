# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

### Prerequisites

Install `chezmoi` on your system. E.g. with `brew` or any package manager on your system.

### Quickstart

```bash
# Initialize with this repository
chezmoi init https://github.com/michal-grzelak/dotfiles.git

# Preview changes
chezmoi diff

# Apply changes
chezmoi apply
```

## Directory Structure

```
dotfiles/
├── .chezmoiroot           # Points chezmoi to source files
├── home/                  # Chezmoi source directory
│   ├── ...
```

## Daily Operations

Do not edit files managed by chezmoi directly. Instead, use `chezmoi edit` to edit source files and re-apply changes.

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
```
