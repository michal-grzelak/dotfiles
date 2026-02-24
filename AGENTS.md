# Chezmoi Dotfiles Agent Reference

This repository manages dotfiles using [chezmoi](https://chezmoi.io), a declarative dotfile manager that handles configuration across multiple machines with templating, encryption, and external resource integration.

**For detailed examples and authoritative reference, query Context7: `/websites/chezmoi_io`**

Below is presented only a fraction of key information.

Chezmoi docs are the source of truth for every detail.

For any topic, DO NOT base your answer only on this file. ALWAYS when user asks about a topic, enrich the answer with detailed information from documentation. Information below is only a summary of key concepts. Every pattern MUST be checked in documentation. You MUST ALWAYS verify your knowledge and answer with documentation. BEFORE you make any change - analyze the documentation. Present the answer to user that will explain WHAT, WHY, WHEN and HOW.

## How Chezmoi Works

Chezmoi maintains three states:

- **Source state**: Declares the desired state of your **Destination directory**, through files and templates in `/home` in this repository
- **Target state**: The desired state of **destination directory** computed from source state
- **Destination directory**: Your actual home directory managed by chezmoi (`~` or `$HOME`)
- **Destination state**: The actual current state of destination directory

The `chezmoi apply` command reconciles destination state with target state, making minimal necessary changes.

Repository root and chezmoi root directories are different things. Chezmoi root can be set via `.chezmoiroot` file. In this repository this is `<repository_root>/home` directory. By default, it's the repository root. Chezmoi root represents the **Source state**.

Nesting chezmoi root allows you to have files in the repository that are not part of the source state.

## File Naming Conventions

Chezmoi uses **attributes** (prefixes and suffixes) to control how files are handled. See docs for all of them. Multiple prefixes can be combined (order matters).

**Use `modify_`** for extensible configs where users add local entries, but beware - they should be **idempotent** or the file content will be duplicated on each run.

**Use `create_` or `empty_`** for ensuring file exists (won't be managed by chezmoi after creation).

**Use `private_`** for sensitive files (SSH keys, credentials).

Understand the difference between source and destination states to avoid confusion when managing files and templates. In the source state, files are defined with attributes and templates. The target state is what the destination directory should look like after applying changes. So e.g. `dot_gitconfig.tmpl` in source state will become `.gitconfig` in destination directory. E.g. when I want to create `.config/app/config.toml` file, then in the source state it should be `dot_config/app/config.toml`.

When loading files inside files, you must remember that they will load files from destination state. This only concerns a scenario if files are loaded with tool or shell native capabilities. However, if you load files with `include` or `includeTemplate` function in a template, then they will be loaded from source state. This is an important distinction to understand when managing files and templates. This behavior can be changed by leveraging `.chezmoi.sourceDir` and `chezmoi.destDir` variables in templates and joining paths. Refer to docs for details.

ALWAYS map the destination path to source path and vice versa by using documentation.

## Template System

Chezmoi uses Go's `text/template` with Sprig functions.

Docs available at context7:

- Sprig: `/masterminds/sprig`
- Go: `/websites/go_dev_doc`

Template files have `.tmpl` suffix.

**Use templates** for dynamic content (email, name, machine-specific paths).

WHENEVER possible, prefer the following pattern for templates:

- `file.ext.tmpl` that imports `file.common.ext`, `file.linux.ext`, `file.darwin.ext` etc. with `include` function to combine them based on conditions
- `file.ext.tmpl` can also have some parts that use templating features and are not possible to be exported to separate files, e.g. email and name parts in `.gitconfig` use templating variables
- this way editor intellisense will work for every file
- `.tmpl` suffix disables intellisense, so it's best to use it only for the main file that combines others, and keep the rest without `.tmpl` suffix
- this pattern can be used with other templates as well, e.g. `file.ext.tmpl` can import `file.common.ext.tmpl` with `includeTemplate` and so on
- ultimately, base files should be without `.tmpl` for easy editing with intellisense
- files that are included in templates (`*.linux.ext`, `*.darwin.ext` etc.) should not contain `MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit` comment, because they are not managed by chezmoi directly, but rather imported into other files that are managed by chezmoi

### Built-in Variables

Builtin variables are accessed via `.chezmoi.*`

### User-Defined Variables

Set in `.chezmoi.toml.tmpl` under `[data]`:

```toml
[data]
    email = "user@example.com"
    name = "John Doe"
```

Access in templates: `{{ .email }}`, `{{ .name }}`.

They can also be set using **Data files**.

### Data Files

Place JSON/JSONC/YAML/TOML files in `.chezmoidata/` directory. Variables become available automatically.

### Template Functions

## Key Concepts

### Scripts

Scripts are files with the `run_` prefix. They execute during `chezmoi apply`.

All scripts should be **idempotent** (safe to run multiple times).

Scripts SHOULD be created inside `.chezmoiscripts/`, so that they are not copied to destination directory, UNLESS they should specifically be in the destination directory.

Scripts can be rerun (`run_onchange`) when content of another file changes, by using the pattern: `# dconf.ini hash: {{ include "dconf.ini" | sha256sum }}` (example) in the script. This way the script will only run when the hash changes, meaning the content of `dconf.ini` changed.

PREFER relative paths in the `include` function.

Scripts can have different formats if **Interpreters** are set up.

If you have logic in scripts, take into account that they usually will take into account state of destination directory, not source directory when using tools. So e.g. if script installs brew packages based on brewfile that is read from destination directory, then this script should be executed after the file is applied to destination directory. Analyze scripts and their dependencies carefully to ensure they run at the right time.

### External Resources

Declare external resources in `.chezmoiexternals/` directory to download automatically.

Prefer directory instead of `.chezmoiexternal.toml` for better organization.

### Hooks

Configure to run commands at lifecycle points.

### Ignoring Files

Create `.chezmoiignore.tmpl` to exclude files from management.

Files that are included in templates (e.g. `file.linux.ext` included in `file.ext.tmpl`) are ignored, to no duplicate content in destination directory. They are not managed by chezmoi directly, but rather imported into other files that are managed by chezmoi.

## Security & Secrets

### Encryption

Chezmoi supports **age** (preferred) and GPG for encrypting sensitive files.

Chezmoi integrates with apps like 1Password for sensitive data retrieval.

## Workflow Quick Reference

### Daily Operations

| Command                   | Purpose                          |
| ------------------------- | -------------------------------- |
| `chezmoi cd`              | Navigate to source directory     |
| `chezmoi diff`            | Preview changes before applying  |
| `chezmoi apply`           | Apply changes to destination     |
| `chezmoi apply --dry-run` | Preview changes without applying |
| `chezmoi edit ~/.bashrc`  | Edit source and re-apply         |
| `chezmoi status`          | Show status of managed files     |
| `chezmoi doctor`          | Check installation health        |

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

## Best Practices

1. **Keep secrets encrypted** - Never commit unencrypted secrets
2. **Test with `chezmoi diff`** before applying changes
3. **Correct shebang**: `#!/usr/bin/env bash` (not `/bin/bash`)
4. In shell scripts or code that will be executed directly on user machine, use `~` for user home directory instead of hardcoding paths, to ensure portability across machines. Differentiate when source paths (relative to source directory) and where destination paths (actual user paths) are needed.
5. Each file managed exclusively by chezmoi should have a comment header `MANAGED BY CHEZMOI! EDIT ONLY WITH: chezmoi edit`. Not every file might need it. Comment should use the same syntax as the file type, e.g. `#` for shell scripts, even if this is a `.tmpl` file, because template files are rendered to destination directory with respective extension.

## Documentation Reference

For authoritative details and examples, query Context7 `/websites/chezmoi_io`.

Chezmoi docs are the source of truth. Use Context7 when implementing specific features.

When in doubt, refer to the official documentation or ask for clarification.

DO NOT base your answer only on this file. ALWAYS when user asks about a topic, enrich the answer with detailed information from documentation. Present the answer that will explain WHAT, WHY, WHEN and HOW.

Under no circumstances query `/twpayne/chezmoi`.
