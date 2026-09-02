Sourced by `~/.zshrc` in filename order. The numbers encode real dependencies:

| file | why it sits there |
| --- | --- |
| `00-options` | `bindkey -v` copies the vi keymap over `main`; anything bound before it is lost |
| `10-completion` | `compinit` must run before fzf-tab can wrap it |
| `20-plugins` | fzf-tab, autosuggestions, p10k theme |
| `30-tools` | asdf, lazy nvm, `fzf --zsh` and `zoxide init` define widgets `50-keybinds` binds |
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
- `nvm` is lazy: the first `nvm`/`node`/`npm`/`npx` call sources `nvm.sh`.
  Nothing else pays for it.
- asdf is sourced from a hardcoded path. `$(brew --prefix asdf)` starts
  Homebrew's Ruby, which alone cost several hundred ms on every shell.
