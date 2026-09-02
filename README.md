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
| `.local/scripts` | `zsh-plugins` |
| `.inputrc` | readline vi mode |

## Requirements

`Brewfile` is a dump of this machine, so a new box is:

```sh
brew bundle install --file=~/.dotfiles/Brewfile
```

It covers ghostty, aerospace, borders (aerospace has no focus ring without it),
neovim, tmux, fzf, zoxide, bat, eza, fd, ripgrep, git-delta, direnv and asdf.
`git-delta` is not optional: `.gitconfig` sets it as `core.pager`.

The terminal font is JetBrainsMono Nerd Font, matching the arch branch. It is
in the Brewfile, so `brew bundle` installs it.

Run `macos-defaults.sh` once per machine, then log out. It mainly disables the
macOS 15+ edge-drag tiling, which resizes windows behind aerospace's back.

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

```sh
~/.local/scripts/zsh-plugins
```

Clones powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting,
zsh-completions and fzf-tab into `~/.local/share/zsh/plugins/`, or pulls them
if already present. Idempotent, so it is both the bootstrap and the updater.

To add a plugin: clone it next to the others, then add one `source` line to
`.config/zsh/20-plugins.zsh` (or `10-completion.zsh` if it ships completions,
which must be on fpath before compinit).

### tmux plugins

tpm lives at `~/.config/tmux/plugins/tpm`. `tmux.conf` still falls back to
`~/.tmux/plugins/tpm` for a fresh machine where tpm gets cloned there instead.
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

- `.config/nvim` is a submodule with its own branches (`main`), so `git push`
  does not recurse into it. Push it separately and FIRST, or a fresh clone of
  this branch cannot fetch the commit it points at:
  `git -C .config/nvim push origin main`
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
