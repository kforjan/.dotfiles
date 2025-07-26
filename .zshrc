# Enable Powerlevel10k instant prompt. 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/.local/scripts/"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-completions
  zsh-autosuggestions
  fzf-tab
  sudo
  flutter
  vi-mode
  command-not-found
)

source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s '^[t' "tmux-sessionizer\n"

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


alias vim='~/bin/nvim-linux-x86_64.appimage'
alias nvim='~/bin/nvim-linux-x86_64.appimage'
alias c='clear'
alias fg='dart run build_runner build --delete-conflicting-outputs'
alias fgw='dart run build_runner watch --delete-conflicting-outputs'
alias cat='bat'
alias air='~/go/bin/air'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export TERMINAL=/snap/bin/alacritty
export PATH="$HOME/Development/Flutter/bin/flutter/bin:$PATH"
