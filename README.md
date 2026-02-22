# Bootstrap

## Install `chezmoi`

Follow https://www.chezmoi.io/install/

Typically on Windows:

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
| [Fish](https://fishshell.com/) | — | `sudo apt install fish` <br> `chsh -s $(which fish)` |
| [Starship](https://starship.rs/) | `winget install --id Starship.Starship` | `curl -sS https://starship.rs/install.sh \| sh` |
| [tmux](https://github.com/tmux/tmux) | — | `sudo apt install tmux` |
| [Git](https://git-scm.com/install/) | `winget install --id Git.Git -e --source winget` | `sudo apt-get install git` |
| [lazygit](https://github.com/jesseduffield/lazygit) | `winget install JesseDuffield.lazygit` | See [releases](https://github.com/jesseduffield/lazygit/releases) |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `winget install BurntSushi.ripgrep.MSVC` | `sudo apt-get install ripgrep` <br> or see https://github.com/BurntSushi/ripgrep/releases |
| [fzf](https://github.com/junegunn/fzf) | `winget install junegunn.fzf` | `sudo apt install fzf` |
| [fd](https://github.com/sharkdp/fd) | `winget install sharkdp.fd` | `sudo apt install fd-find` <br> `ln -s $(which fdfind) ~/.local/bin/fd` |
| [bat](https://github.com/sharkdp/bat) | `winget install sharkdp.bat` | `sudo apt install bat` <br> `ln -s $(which batcat) ~/.local/bin/bat` |
| [jq](https://github.com/jqlang/jq) | `winget install stedolan.jq` | `sudo apt install jq` |
| [yq](https://github.com/mikefarah/yq) | `winget install MikeFarah.yq` | `snap install yq` |
| [Neovim](https://neovim.io/doc/install/) | `winget install Neovim.Neovim` | `sudo apt install neovim` |
| [uv](https://docs.astral.sh/uv/getting-started/installation/) | `irm https://astral.sh/uv/install.ps1 \| iex` | `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| [Rust](https://rust-lang.org/tools/install/)<br>incl. `rustup`, `cargo` | [rustup-init.exe](https://rustup.rs/) | `curl https://sh.rustup.rs -sSf \| sh` |
