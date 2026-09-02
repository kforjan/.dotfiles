# kforjan's dotfiles — macOS

Branches: `macos` (this one), `arch`, `main`.

## Install

```sh
git clone --recurse-submodules git@github.com:kforjan/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow .
```

`.config/nvim` is a submodule ([kforjan/config.nvim](https://github.com/kforjan/config.nvim)) shared
with the `arch` branch; `git submodule update --init` if you cloned without `--recurse-submodules`.

## What's in here

| Path | Tool |
| --- | --- |
| `.zshenv` | PATH + env for *every* zsh, interactive or not |
| `.zshrc`, `.config/zsh/` | interactive zsh, split by concern (see its README) |
| `.p10k.zsh` | powerlevel10k prompt |
| `.gitconfig`, `.gitignore_global` | git + delta |
| `.config/ghostty` | terminal |
| `.config/tmux` | tmux (plugins via tpm, not tracked) |
| `.config/nvim` | neovim (submodule) |
| `.config/aerospace` | tiling window manager |
| `.config/alacritty` | legacy terminal, superseded by ghostty |
| `.inputrc` | readline vi mode |

## Requirements

```sh
# terminal + shell
brew install --cask ghostty
brew install zsh stow tmux neovim

# CLI tools the configs assume
brew install fzf zoxide bat eza fd ripgrep git-delta direnv jq

# window manager
brew install --cask nikitabobko/tap/aerospace
brew install felixkratz/formulae/borders     # focus ring for aerospace

# font
brew install --cask font-fira-code-nerd-font
```

`git-delta` is not optional — `.gitconfig` sets it as `core.pager`, so git will
error on every diff without it.

### zsh plugins

`.zshrc` sources these directly (no framework). The `~/.oh-my-zsh/custom` paths
are kept only so both branches share one layout:

```sh
ZC=~/.oh-my-zsh/custom
mkdir -p $ZC/themes $ZC/plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k             $ZC/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions     $ZC/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $ZC/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-completions         $ZC/plugins/zsh-completions
git clone --depth=1 https://github.com/Aloxaf/fzf-tab                    $ZC/plugins/fzf-tab
```

### tmux plugins

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Then `prefix + I` inside tmux. `tmux.conf` falls back to `~/.tmux/plugins/tpm`
if the XDG path doesn't exist yet.

### optional

```sh
brew tap homebrew/command-not-found   # "did you mean brew install X" in zsh
```

## Notes

- Completion cache lives in `~/.cache/zsh` and is rebuilt at most once a day.
  After `brew install`ing something with completions: `rm ~/.cache/zsh/zcompdump-*`.
- The old `.zshrc` sourced `.env` from the current directory at startup. That is
  gone — any cloned repo could execute code in your shell. `direnv` does the
  same job safely; run `direnv allow` per project.
