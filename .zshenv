typeset -U path fpath

path=(
  $HOME/.local/bin
  $HOME/.local/scripts
  $HOME/.asdf/shims
  $HOME/.fvm_flutter/bin
  $HOME/Development/bin/flutter/bin
  $HOME/.pub-cache/bin
  $HOME/go/bin
  $HOME/.lmstudio/bin
  $HOME/.config/herd-lite/bin
  /usr/local/android-studio/bin
  $path
)

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=ghostty
export BAT_THEME=base16-256
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
