alias vim=nvim
alias c=clear
(( $+commands[bat] )) && alias cat='bat --paging=never'

if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -l --group-directories-first --git --icons=auto'
  alias la='eza -la --group-directories-first --git --icons=auto'
  alias lt='eza --tree --level=2 --icons=auto'
else
  alias ls='ls -G'
  alias ll='ls -lhG'
  alias la='ls -lhaG'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias df='df -h'

alias fg='dart run build_runner build --delete-conflicting-outputs'
alias fgw='dart run build_runner watch --delete-conflicting-outputs'

# macOS niceties
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
