# Chezmoi Dotfiles Agent Reference

This file provides essential reference for AI agents working with this chezmoi-managed dotfiles repository. For detailed examples and tutorials, query Context7 with libraryId `/websites/chezmoi_io`. Chezmoi docs are a source of truth.

---

## File Naming Conventions

### Prefixes

| Prefix          | Purpose                                     | Result                                         |
| --------------- | ------------------------------------------- | ---------------------------------------------- |
| `dot_`          | Becomes `.` (hidden file)                   | `dot_gitconfig` → `.gitconfig`                 |
| `private_`      | Sets permissions to 600                     | `private_dot_ssh/config` → `.ssh/config` (600) |
| `executable_`   | Makes file executable                       | `executable_script.sh`                         |
| `modify_`       | Script that modifies existing file on apply | `modify_dot_gitconfig`                         |
| `run_once_`     | Runs once, never again                      | `run_once_bootstrap.sh`                        |
| `run_onchange_` | Runs when content changes                   | `run_onchange_install-packages.sh`             |
| `create_`       | Creates empty directory                     | `create_dot_config/`                           |
| `symlink_`      | Creates symlink instead of copy             | `symlink_dot_config/nvim`                      |

### Suffixes

| Suffix  | Purpose                  |
| ------- | ------------------------ |
| `.tmpl` | Processed as Go template |
| `.sh`   | Shell script             |

Prefixes can be combined: `private_dot_ssh/config` → `.ssh/config` with 600 permissions.

---

## Template Variables

### Built-in Variables

```go
.chezmoi.os          // "linux", "darwin", "windows"
.chezmoi.arch        // "amd64", "arm64"
.chezmoi.hostname    // Machine hostname
.chezmoi.username    // Current username
.chezmoi.homeDir     // Home directory path
.chezmoi.sourceDir   // Source directory path
```

### User Variables

Defined in `.chezmoi.toml` under `[data]`. Access as `{{ .email }}`, `{{ .name }}`, etc.

### Conditional Logic

```go
{{ if eq .chezmoi.os "darwin" }}...{{ else if eq .chezmoi.os "linux" }}...{{ end }}
{{ if eq .chezmoi.hostname "work-laptop" }}...{{ end }}
```

---

## Key Concepts

### modify\_ Scripts

Scripts that read existing file content via `.chezmoi.stdin` and output modified content. Use for configs where users add their own entries (SSH, git). Query Context7: "chezmoi modify script examples".

### .chezmoiexternal.toml

Declares external resources (archives, git repos, files) to download. Types: `archive`, `archive-file`, `file`, `git-repo`. Query Context7: "chezmoi external resources configuration".

### Scripts

- `run_once_`: Bootstrap/setup, runs once per script hash
- `run_onchange_`: Runs when script content changes
- Use `.chezmoidata/` for data files (YAML, JSON) accessible via templates

### Hooks

Configure in `.chezmoi.toml` under `[hooks]`. Available: `apply.pre/post`, `init.pre/post`, `update.pre/post`, etc.

---

## Best Practices

1. Use templates for dynamic content (email, name, machine-specific paths)
2. Use `modify_` for extensible configs (SSH, git where users add entries)
3. Use `.chezmoiexternal.toml` for plugins/third-party code
4. Use `run_onchange_` for declarative package installation
5. Keep secrets out of repo - use password manager integration
6. Test with `chezmoi diff` before applying
7. Use `private_` prefix for sensitive files
8. Use `.chezmoiignore` to exclude machine-specific files
9. Commit idempotent scripts (safe to run multiple times)
10. Correct bash shebang is `#!/usr/bin/env bash`

---

## Fetching Examples

Use Context7 with `context7___query-docs`:

- libraryId: `/websites/chezmoi_io`
- query: specific topic (e.g., "SSH config modify script", "external git repo", "template functions")
- this docs are the source of truth
