if [[ -n $HOMEBREW_PREFIX && -r $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh ]]; then
  source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi

export NVM_DIR=$HOME/.nvm
if [[ -s $NVM_DIR/nvm.sh ]]; then
  _load_nvm() {
    unfunction nvm node npm npx 2>/dev/null
    source $NVM_DIR/nvm.sh
    [[ -s $NVM_DIR/bash_completion ]] && source $NVM_DIR/bash_completion
  }
  nvm()  { _load_nvm; nvm "$@" }
  node() { _load_nvm; node "$@" }
  npm()  { _load_nvm; npm "$@" }
  npx()  { _load_nvm; npx "$@" }
fi

(( $+commands[zoxide] )) && eval "$(zoxide init --cmd cd zsh)"

if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
elif [[ -n $HOMEBREW_PREFIX && -r $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh ]]; then
  source $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh
  source $HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh
fi

if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --info=inline'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {} 2>/dev/null || ls -G {}'"
export FZF_ALT_C_OPTS="--preview 'ls -G {}'"

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
