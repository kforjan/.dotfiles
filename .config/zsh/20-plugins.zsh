source $ZPLUG/themes/powerlevel10k/powerlevel10k.zsh-theme
source $ZPLUG/plugins/fzf-tab/fzf-tab.plugin.zsh
source $ZPLUG/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]] &&
  source /usr/share/doc/pkgfile/command-not-found.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
