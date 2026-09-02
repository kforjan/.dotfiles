alias vim=nvim
alias c=clear
alias cat='bat --paging=never'

if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -l --group-directories-first --git --icons=auto'
  alias la='eza -la --group-directories-first --git --icons=auto'
  alias lt='eza --tree --level=2 --icons=auto'
else
  alias ls='ls --color=auto --group-directories-first'
  alias ll='ls -lh --color=auto --group-directories-first'
  alias la='ls -lha --color=auto --group-directories-first'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias df='df -h'
alias free='free -h'
alias ip='ip -color=auto'

alias fg='dart run build_runner build --delete-conflicting-outputs'
alias fgw='dart run build_runner watch --delete-conflicting-outputs'

studio() { command studio "$@" &>/dev/null & disown }
