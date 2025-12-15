# Bootstrap

## Install `chezmoi`

Follow https://www.chezmoi.io/install/

Typpically on Windows:

```pwsh
winget install twpayne.chezmoi
```

On Ubuntu:

```sh
snap install chezmoi --classic
```

## Apply dotfiles

```sh
chezmoi init https://github.com/ligz08/chezmoi-dotfiles.git
```

# Software (wish) list

| Software | Windows | Ubuntu |
|---|---|---|
| [Git](https://git-scm.com/install/) | `winget install --id Git.Git -e --source winget` | `sudo apt-get install git` |
| [uv](https://docs.astral.sh/uv/getting-started/installation/) | `irm https://astral.sh/uv/install.ps1 \| iex` | `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| [Neovim](https://neovim.io/doc/install/) | `winget install Neovim.Neovim` | `sudo apt install neovim` |
| [ripgrip](https://github.com/BurntSushi/ripgrep) | `winget install BurntSushi.ripgrep.MSVC` | `sudo apt-get install ripgrep` <br> or see https://github.com/BurntSushi/ripgrep/releases |
| [Rust](https://rust-lang.org/tools/install/)<br>incl. `rustup`, `cargo` | [rustup-init.exe](https://rustup.rs/) | `curl https://sh.rustup.rs -sSf \| sh` |
