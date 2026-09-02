_dotfiles_path() {
  typeset -gU path fpath

  if [[ -x /opt/homebrew/bin/brew ]]; then
    export HOMEBREW_PREFIX=/opt/homebrew
  elif [[ -x /usr/local/bin/brew ]]; then
    export HOMEBREW_PREFIX=/usr/local
  fi

  if [[ -n $HOMEBREW_PREFIX ]]; then
    export HOMEBREW_CELLAR=$HOMEBREW_PREFIX/Cellar
    export HOMEBREW_REPOSITORY=$HOMEBREW_PREFIX
    export MANPATH=$HOMEBREW_PREFIX/share/man:$MANPATH
    export INFOPATH=$HOMEBREW_PREFIX/share/info:$INFOPATH
    path=($HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $path)
  fi

  path=(
    $HOME/.local/bin
    $HOME/.asdf/shims
    $HOME/.pub-cache/bin
    $HOME/go/bin
    $path
  )
}
_dotfiles_path

export EDITOR=nvim
export VISUAL=nvim
export BAT_THEME=base16-256

export RUBYOPT="-r$HOME/.rubyopenssl_default_store.rb $RUBYOPT"
