Sourced by `~/.zshrc` in filename order. The numbers encode real dependencies:

| file | why it sits there |
| --- | --- |
| `00-options` | `bindkey -v` copies the vi keymap over `main`; anything bound before it is lost |
| `10-completion` | `compinit` must run before fzf-tab can wrap it |
| `20-plugins` | fzf-tab, autosuggestions, p10k theme |
| `30-tools` | lazy nvm, `fzf --zsh` and `zoxide init` define widgets `50-keybinds` binds |
| `40-aliases` | no ordering constraints |
| `50-keybinds` | needs widgets from 20 and 30 to exist |
| `90-prompt` | `~/.p10k.zsh` |
| `99-highlight` | zsh-syntax-highlighting wraps every widget bound so far, so it goes last |

Files not matching `[0-9]*.zsh` are ignored, so scratch files are safe to leave here.

## macOS notes

- PATH is built by `_dotfiles_path` in `~/.zshenv` and re-run at the top of
  `~/.zshrc`. That is deliberate: `/etc/zprofile` runs `path_helper` in between,
  which reorders PATH and pushes `/usr/bin` ahead of Homebrew. `typeset -U path`
  makes the second call idempotent.
- Homebrew's env is hardcoded rather than `eval "$(brew shellenv)"` — same
  result, one less subprocess per shell.
- `nvm` is lazy, but node is not. `.zshenv` puts nvm's default version on PATH
  outright, because Homebrew ships its own node as a dependency of firebase-cli,
  heroku and prettierd. Sourcing `nvm.sh` only in `.zshrc` would leave every
  non-interactive shell on the Homebrew build, so `node` in a terminal and
  `node` in a Makefile would disagree. The first `nvm` call sources the script.
- asdf needs no shell integration at 0.16+; it is a Go binary driven entirely by
  `~/.asdf/shims`, which `.zshenv` adds. There is nothing to source.
- `LS_COLORS` is set in `10-completion` because macOS has no `dircolors`. Both
  the completion menu and eza read it.
