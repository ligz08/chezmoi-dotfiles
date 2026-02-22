# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A [chezmoi](https://www.chezmoi.io/) dotfiles repository managing shell configs, editor settings, and CLI tool configuration across Windows and Ubuntu. Source of truth lives at `~/.local/share/chezmoi/`.

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
- `run_once_after_` prefix -> runs once after apply, tracked by chezmoi

### Centralized Alias System

**Aliases are defined once in `.chezmoidata.toml` and generated for all three shells.** Do not edit alias files directly.

- `.chezmoidata.toml` -> single source of truth for `[[aliases]]`
- `dot_bash_aliases.tmpl` -> generates `~/.bash_aliases`
- `dot_config/fish/conf.d/abbreviations.fish.tmpl` -> generates fish abbreviations
- `dot_config/powershell/psaliases.ps1.tmpl` -> generates PowerShell `Set-Alias` commands

Each alias entry supports per-shell overrides:
- `pwsh_command` -> use a different command on PowerShell
- `pwsh_only`, `bash_only`, `fish_only` -> restrict to specific shell(s)

### Cross-Platform Scripts

Run scripts use `.tmpl` with OS guards (`{{ if eq .chezmoi.os "windows" }}`) to execute only on the appropriate platform:
- `run_apply-powershell-profile.ps1.tmpl` -> Windows-only: wires chezmoi-managed profile into PowerShell's profile path
- `run_once_after_symlink-nvim-windows.ps1.tmpl` -> Windows-only: symlinks `~/.config/nvim` to `~/AppData/Local/nvim`

### Managed Configurations

| Component | Source Path | Notes |
|-----------|-----------|-------|
| Bash | `dot_bashrc`, `dot_bash_aliases.tmpl` | Aliases are templated |
| Fish | `dot_config/fish/` | Uses starship prompt, abbreviations templated |
| PowerShell | `dot_config/powershell/` | `profile.ps1` sources `ps*.ps1` files; includes PATH management functions |
| Neovim | `dot_config/nvim/` | Lua config with lazy.nvim plugin manager |
| Git | `dot_gitconfig` | Includes `~/org.gitconfig` and `~/private.gitconfig` (not managed here) |
| Starship | `dot_config/starship/starship.toml` | Shared prompt across fish and PowerShell |
| tmux | `dot_config/tmux/tmux.conf` | Prefix is `Ctrl-Space`, vim-style navigation |

### Neovim Plugin Architecture

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) with plugin specs in `dot_config/nvim/lua/plugins/init.lua`. Bootstrap code is in `dot_config/nvim/lua/config/lazy.lua`. Leader key is `<Space>`.

## When Adding New Configuration

- **New alias**: Add an `[[aliases]]` entry to `.chezmoidata.toml` -- all shell alias files regenerate automatically.
- **New config file**: Use `chezmoi add` or manually create with proper `dot_` prefix naming.
- **Platform-specific logic**: Use `.tmpl` suffix with `{{ if eq .chezmoi.os "windows" }}` / `{{ if eq .chezmoi.os "linux" }}` guards.
- **New Neovim plugin**: Add a plugin spec table to `dot_config/nvim/lua/plugins/init.lua`.
