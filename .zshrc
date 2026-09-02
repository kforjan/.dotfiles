if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Interactive config lives in ~/.config/zsh, sourced in filename order.
ZDOTFILES=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
ZPLUG=$HOME/.oh-my-zsh/custom

for _zf in $ZDOTFILES/[0-9]*.zsh(N); do
  source $_zf
done
unset _zf
