eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --info=inline'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {} 2>/dev/null || ls --color {}'"
export FZF_ALT_C_OPTS="--preview 'ls --color {}'"

[[ -f $HOME/.config/.dart-cli-completion/zsh-config.zsh ]] &&
  source $HOME/.config/.dart-cli-completion/zsh-config.zsh

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
