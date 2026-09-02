source $ZPLUGINS/powerlevel10k/powerlevel10k.zsh-theme
source $ZPLUGINS/fzf-tab/fzf-tab.plugin.zsh
source $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

if [[ -n $HOMEBREW_PREFIX && -r $HOMEBREW_PREFIX/Library/Taps/homebrew/homebrew-command-not-found/handler.sh ]]; then
  source $HOMEBREW_PREFIX/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
fi

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
