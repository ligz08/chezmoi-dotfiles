# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A [chezmoi](https://www.chezmoi.io/) dotfiles repository managing shell configs, editor settings, and CLI tool configuration across Windows and Ubuntu. Source of truth lives at `~/.local/share/chezmoi/`. See [chezmoi reference](https://www.chezmoi.io/reference/) for full documentation.

## Key Commands

```bash
chezmoi apply              # Apply dotfiles to home directory
chezmoi apply -n           # Dry-run (preview changes without applying)
chezmoi diff               # Show diff between managed and actual files
chezmoi edit <target>      # Edit a managed file (opens source file)
chezmoi add <file>         # Add a new file to chezmoi management
chezmoi managed            # List all managed files
```

## Architecture

### Chezmoi Naming Conventions

Files use chezmoi's naming scheme to map source to target paths:
- `dot_` prefix -> `.` (e.g., `dot_bashrc` -> `~/.bashrc`)
- `dot_config/` -> `~/.config/`
- `.tmpl` suffix -> processed as Go templates before applying
- `run_` prefix -> run scripts executed during `chezmoi apply`
- `run_once_` prefix -> runs once, tracked by chezmoi (re-runs if script content changes)
- `run_once_after_` prefix -> runs once after apply, tracked by chezmoi
- `run_onchange_` prefix -> re-runs only when script content changes (use hash comments to trigger on data changes)

### Centralized Alias System

**Aliases are defined once in `.chezmoidata.toml` and generated for all three shells.** Do not edit alias files directly.

- `.chezmoidata.toml` -> single source of truth for `[[aliases]]`
- `dot_bash_aliases.tmpl` -> generates `~/.bash_aliases`
- `dot_config/fish/conf.d/abbreviations.fish.tmpl` -> generates fish abbreviations
- `dot_config/powershell/psaliases.ps1.tmpl` -> generates PowerShell `Set-Alias` commands

Each alias entry supports per-shell overrides:
- `pwsh_command` -> use a different command on PowerShell
- `pwsh_only`, `bash_only`, `fish_only` -> restrict to specific shell(s)

### Centralized Git Config

**Git configs are also defined in `.chezmoidata.toml` as `[[git_configs]]` entries.** Paired `run_onchange_apply-git-config.{sh,ps1}.tmpl` scripts template from this data and only re-run when `.chezmoidata.toml` changes (via a hash comment). Settings are applied additively via `git config --global`, preserving local settings like `user.name`.

### Cross-Platform Scripts

Run scripts use `.tmpl` with OS guards (`{{ if eq .chezmoi.os "windows" }}`) to execute only on the appropriate platform:
- `run_apply-powershell-profile.ps1.tmpl` -> Windows-only: wires chezmoi-managed profile into PowerShell's profile path
- `run_once_after_symlink-nvim-windows.ps1.tmpl` -> Windows-only: symlinks `~/.config/nvim` to `~/AppData/Local/nvim`
- `run_once_bootstrap-tpm.sh.tmpl` -> Linux-only: clones TPM on first apply

### Managed Configurations

| Component | Source Path | Notes |
|-----------|-----------|-------|
| Bash | `dot_bashrc`, `dot_bash_aliases.tmpl` | Aliases are templated; uses starship prompt |
| Fish | `dot_config/fish/` | Uses starship prompt, abbreviations templated |
| PowerShell | `dot_config/powershell/` | `profile.ps1` sources `ps*.ps1` files; includes PATH management functions |
| Neovim | `dot_config/nvim/` | Lua config with lazy.nvim plugin manager |
| Git | `run_onchange_apply-git-config.{sh,ps1}.tmpl` | Applied additively via `git config --global`; configs defined in `.chezmoidata.toml` |
| Starship | `dot_config/starship/starship.toml` | Shared prompt across bash, fish, and PowerShell |
| tmux | `dot_config/tmux/tmux.conf` | Prefix is `Ctrl-Space`, vim-style navigation |

### Neovim Plugin Architecture

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) with plugin specs in `dot_config/nvim/lua/plugins/init.lua`. Bootstrap code is in `dot_config/nvim/lua/config/lazy.lua`. Leader key is `<Space>`.

## When Adding New Configuration

- **New alias**: Add an `[[aliases]]` entry to `.chezmoidata.toml` -- all shell alias files regenerate automatically.
- **New git config**: Add a `[[git_configs]]` entry to `.chezmoidata.toml` with `key` and `value` fields.
- **New config file**: Use `chezmoi add` or manually create with proper `dot_` prefix naming.
- **Platform-specific logic**: Use `.tmpl` suffix with `{{ if eq .chezmoi.os "windows" }}` / `{{ if eq .chezmoi.os "linux" }}` guards.
- **Cross-platform run scripts**: For identical commands on both OSes, define data in `.chezmoidata.toml` and create paired `.sh.tmpl` / `.ps1.tmpl` scripts with OS guards to avoid duplication.
- **Repo-only files**: Add to `.chezmoiignore` so `chezmoi apply` skips them (e.g., `LICENSE`, `README.md`, `CLAUDE.md`).
- **Platform-specific ignores**: `.chezmoiignore` supports Go templates — use OS guards to skip Linux-only files on Windows and vice versa.
- **New Neovim plugin**: Add a plugin spec table to `dot_config/nvim/lua/plugins/init.lua`.
- **Optional tool init**: Guard with `command -v <tool>` (bash) or `command -q <tool>` (fish) before calling tools that may not be installed (e.g., starship, cargo).
