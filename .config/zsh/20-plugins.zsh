source $ZPLUGINS/powerlevel10k/powerlevel10k.zsh-theme
source $ZPLUGINS/fzf-tab/fzf-tab.plugin.zsh
source $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]] &&
  source /usr/share/doc/pkgfile/command-not-found.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
