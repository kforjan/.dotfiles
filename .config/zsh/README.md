Sourced by `~/.zshrc` in filename order. The numbers encode real dependencies:

| file | why it sits there |
| --- | --- |
| `00-options` | `bindkey -v` copies the vi keymap over `main`; anything bound before it is lost |
| `10-completion` | `compinit` must run before fzf-tab can wrap it |
| `20-plugins` | fzf-tab, autosuggestions, p10k theme |
| `30-tools` | `fzf --zsh` binds its own `^R`/`^T`/`Alt-C`; don't re-bind them in 50 |
| `40-aliases` | no ordering constraints |
| `50-keybinds` | binds `autosuggest-accept`, so it needs 20 loaded first |
| `90-prompt` | `~/.p10k.zsh` |
| `99-highlight` | zsh-syntax-highlighting wraps every widget bound so far, so it goes last |

Files not matching `[0-9]*.zsh` are ignored, so scratch files are safe to leave here.
