# Chezmoi Dotfiles Agent Reference

This repository manages dotfiles using [chezmoi](https://chezmoi.io), a declarative dotfile manager that handles configuration across multiple machines with templating, encryption, and external resource integration.

**For detailed examples and authoritative reference, query Context7: `/websites/chezmoi_io`**

Below is presented only a fraction of key information.

Chezmoi docs are the source of truth for every detail.

When asked about a topic, enrich it with detailed information from documentation. Present the answer that will explain WHAT, WHY, WHEN and HOW.

## How Chezmoi Works

Chezmoi maintains three states:

- **Source state**: Files in this repo (under `home/` or at repo root) with chezmoi-specific naming
- **Target state**: The desired state computed from source state, templates, and config
- **Destination state**: Your actual home directory (`~`)

The `chezmoi apply` command reconciles destination state with target state, making minimal necessary changes.

## File Naming Conventions

Chezmoi uses **attributes** (prefixes and suffixes) to control how files are handled. Multiple prefixes can be combined (order matters).

## Template System

Chezmoi uses Go's `text/template` with Sprig functions.

Docs available at context7:

- Sprig: `/masterminds/sprig`
- Go: `/websites/go_dev_doc`

### Built-in Variables

Builtin variables are accessed via `.chezmoi.*`

### User-Defined Variables

Set in `.chezmoi.toml.tmpl` under `[data]`:

```toml
[data]
    email = "user@example.com"
    name = "John Doe"
```

Access in templates: `{{ .email }}`, `{{ .name }}`

### Data Files

Place JSON/JSONC/YAML/TOML files in `.chezmoidata/` directory. Variables become available automatically.

### Template Functions

## Key Concepts

### Scripts

Scripts are files with the `run_` prefix. They execute during `chezmoi apply`.

All scripts should be **idempotent** (safe to run multiple times).

### Modify Scripts

Use `modify_` when you need to merge chezmoi-managed config with user-local changes.

Changes should be **idempotent** or the file content will be duplicated on each run.

### External Resources

Declare external resources in `.chezmoiexternal.toml` to download automatically.

### Hooks

Configure to run commands at lifecycle points.

### Ignoring Files

Create `.chezmoiignore.tmpl` to exclude files from management.

## Security & Secrets

### Encryption

Chezmoi supports **age** (preferred) and GPG for encrypting sensitive files.

Chezmoi integrates with apps like 1Password for sensitive data retrieval.

## Workflow Quick Reference

### Daily Operations

| Command                   | Purpose                         |
| ------------------------- | ------------------------------- |
| `chezmoi cd`              | Navigate to source directory    |
| `chezmoi diff`            | Preview changes before applying |
| `chezmoi apply`           | Apply changes to destination    |
| `chezmoi apply ~/.bashrc` | Apply single file               |
| `chezmoi add ~/.bashrc`   | Add file to source state        |
| `chezmoi edit ~/.bashrc`  | Edit source and re-apply        |
| `chezmoi status`          | Show status of managed files    |
| `chezmoi doctor`          | Check installation health       |

There are many more commands.

### Machine Setup

| Command                           | Purpose                       |
| --------------------------------- | ----------------------------- |
| `chezmoi init <repo-url>`         | Initialize on new machine     |
| `chezmoi init --apply <repo-url>` | Init and apply in one step    |
| `chezmoi update`                  | Pull and apply latest changes |

### File Management

| Command                                         | Purpose                                      |
| ----------------------------------------------- | -------------------------------------------- |
| `chezmoi add --template ~/.config/app`          | Add as template                              |
| `chezmoi add --autotemplate ~/.bashrc`          | Auto-create template with existing variables |
| `chezmoi add --encrypt ~/.ssh/key`              | Add encrypted file                           |
| `chezmoi add --empty ~/.config/app/placeholder` | Ensure empty file exists                     |
| `chezmoi chattr +template ~/.bashrc`            | Add template attribute to existing file      |
| `chezmoi chattr +private ~/.netrc`              | Add private attribute to existing file       |
| `chezmoi cat ~/.bashrc`                         | View source content                          |
| `chezmoi source-path ~/.bashrc`                 | Get source path for target                   |

---

## Best Practices

1. **Use templates** for dynamic content (email, name, machine-specific paths)
2. **Use `modify_`** for extensible configs where users add local entries, but beware of making it **idempotent**
3. **Use `create_` or `empty_`** for ensuring file exists (won't be managed by chezmoi after creation)
4. **Use `.chezmoiexternal.toml`** for plugins, themes, and third-party code
5. **Use `run_onchange_`** for declarative package/software installation
6. **Keep secrets encrypted** - Never commit unencrypted secrets
7. **Use `private_`** for sensitive files (SSH keys, credentials)
8. **Use `.chezmoiignore`** to exclude machine-specific or temporary files
9. **All scripts and `modify_` must be idempotent** - Safe to run multiple times
10. **Use `before_`/`after_`** scripts for setup/teardown around file updates
11. **Test with `chezmoi diff`** before applying changes
12. **Correct shebang**: `#!/usr/bin/env bash` (not `/bin/bash`)
13. **Prefer `run_onchange_` over `run_once_`** when filename matters for re-execution
14. **Use data files** in `.chezmoidata/` for machine-specific configuration lists
15. Each file managed exclusively by chezmoi should have a header `MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit`. Not every file might need it

---

## Documentation Reference

For authoritative details and examples, query Context7 `/websites/chezmoi_io`.

Chezmoi docs are the source of truth. Use Context7 when implementing specific features.

Under no circumstances query `/twpayne/chezmoi`.
