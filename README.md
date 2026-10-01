# Bootstrap

## Install `chezmoi`

Follow https://www.chezmoi.io/install/

| Windows | Ubuntu | macOS |
|---|---|---|
| `winget install --id twpayne.chezmoi --source winget` | `snap install chezmoi --classic` | `brew install chezmoi` |

## Apply dotfiles

```sh
chezmoi init https://github.com/ligz08/chezmoi-dotfiles.git
```

# Software wishlist

| Software | Windows | Ubuntu | macOS |
|---|---|---|---|
| [Fish](https://fishshell.com/) | — | `sudo apt install fish` <br> `chsh -s $(which fish)` | `brew install fish` |
| [Starship](https://starship.rs/) | `winget install --id Starship.Starship` | `curl -sS https://starship.rs/install.sh \| sh` | `brew install starship` |
| [tmux](https://github.com/tmux/tmux) | — | `sudo apt install tmux` | `brew install tmux` |
| [Git](https://git-scm.com/install/) | `winget install --id Git.Git -e --source winget` | `sudo apt-get install git` | `brew install git` |
| [GitHub CLI](https://cli.github.com/) | `winget install --id GitHub.cli --source winget` | `sudo apt install gh` | `brew install gh` |
| [lazygit](https://github.com/jesseduffield/lazygit) | `winget install JesseDuffield.lazygit` | See [releases](https://github.com/jesseduffield/lazygit/releases) | `brew install lazygit` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `winget install BurntSushi.ripgrep.MSVC` | `sudo apt-get install ripgrep` <br> or see https://github.com/BurntSushi/ripgrep/releases | `brew install ripgrep` |
| [fzf](https://github.com/junegunn/fzf) | `winget install junegunn.fzf` | `sudo apt install fzf` | `brew install fzf` |
| [fd](https://github.com/sharkdp/fd) | `winget install sharkdp.fd` | `sudo apt install fd-find` <br> `ln -s $(which fdfind) ~/.local/bin/fd` | `brew install fd` |
| [bat](https://github.com/sharkdp/bat) | `winget install sharkdp.bat` | `sudo apt install bat` <br> `ln -s $(which batcat) ~/.local/bin/bat` | `brew install bat` |
| [jq](https://github.com/jqlang/jq) | `winget install jqlang.jq` | `sudo apt install jq` | `brew install jq` |
| [yq](https://github.com/mikefarah/yq) | `winget install MikeFarah.yq` | `snap install yq` | `brew install yq` |
| [Neovim](https://neovim.io/doc/install/) | `winget install Neovim.Neovim` | `sudo apt install neovim` | `brew install neovim` |
| [Helix](https://helix-editor.com/) | `winget install Helix.Helix` | `sudo add-apt-repository ppa:maveonair/helix-editor` <br> `sudo apt update` <br> `sudo apt install helix` | `brew install helix` |
| [uv](https://docs.astral.sh/uv/getting-started/installation/) | `irm https://astral.sh/uv/install.ps1 \| iex` | `curl -LsSf https://astral.sh/uv/install.sh \| sh` | `brew install uv` |
| [Rust](https://rust-lang.org/tools/install/)<br>incl. `rustup`, `cargo` | [rustup-init.exe](https://rustup.rs/) | `curl https://sh.rustup.rs -sSf \| sh` | `curl https://sh.rustup.rs -sSf \| sh` |
