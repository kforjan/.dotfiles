source $ZPLUG/themes/powerlevel10k/powerlevel10k.zsh-theme
source $ZPLUG/plugins/fzf-tab/fzf-tab.plugin.zsh
source $ZPLUG/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

if [[ -n $HOMEBREW_PREFIX && -r $HOMEBREW_PREFIX/Library/Taps/homebrew/homebrew-command-not-found/handler.sh ]]; then
  source $HOMEBREW_PREFIX/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
fi
