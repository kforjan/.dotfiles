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

Verified against this machine (Apple Silicon, macOS 26.5, Homebrew at `/opt/homebrew`).

Already installed: `stow tmux neovim fzf zoxide bat fd ripgrep asdf coreutils`,
`--cask ghostty aerospace`, FiraCode Nerd Font.

Still missing:

```sh
brew install git-delta eza direnv
brew install felixkratz/formulae/borders     # focus ring for aerospace
```

`git-delta` is not optional — `.gitconfig` sets it as `core.pager`, so git
errors on every diff without it. `eza` and `direnv` are both guarded: the `ls`
aliases fall back to BSD `ls -G` and the `direnv` hook is skipped, so the shell
works without them.

For a fresh machine:

```sh
brew install --cask ghostty aerospace font-fira-code-nerd-font
brew install zsh stow tmux neovim fzf zoxide bat eza fd ripgrep git-delta direnv asdf coreutils
brew install felixkratz/formulae/borders
```

### asdf

asdf here is 0.19 (the Go rewrite). It has no `libexec/asdf.sh` and needs no
shell integration — `~/.asdf/shims` on PATH is the whole story. Completions are
not generated automatically:

```sh
asdf completion zsh > ~/.asdf/completions/_asdf
```

It manages ruby only (`~/.tool-versions`). node comes from nvm; `rbenv` is
installed but inert, since asdf's shims precede it on PATH.

### node

`.zshenv` puts nvm's default node on PATH directly rather than sourcing
`nvm.sh`. Homebrew has its own node (a `firebase-cli`/`heroku`/`prettierd`
dependency) which would otherwise win for every non-interactive shell, so
`node` in a terminal and `node` in a Makefile would be different versions.
`nvm` itself stays lazy — first call sources the script.

### zsh plugins

`.zshrc` sources these directly (no framework). The `~/.oh-my-zsh/custom` paths
are kept only so both branches share one layout; oh-my-zsh itself is not loaded.
All five are already present on this machine:

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

tpm is already at `~/.config/tmux/plugins/tpm` (the XDG path `tmux.conf`
prefers; `~/.tmux/plugins/tpm` is a stale leftover and is only a fallback).
`tmux-resurrect` and `tmux-continuum` are declared but not yet cloned, so
`@continuum-restore` does nothing until:

```sh
tmux   # then: prefix + I
```

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
- `aerospace` reads its config at launch. After editing `aerospace.toml` run
  `aerospace reload-config` (or `cmd-shift-semicolon` then `esc`), otherwise the
  running instance keeps the old bindings.
- Startup cost, measured: the pre-rewrite `.zshrc` took ~1980 ms per shell
  (`compinit` ran three times, and `nvm.sh` was sourced eagerly). It is now
  ~52 ms. That stall was the `^[` echo when pressing Escape in a fresh pane.
