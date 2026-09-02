[[ -n $HOMEBREW_PREFIX ]] && fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fpath=($ZPLUGINS/zsh-completions/src $fpath)
[[ -d $HOME/.asdf/completions ]] && fpath=($HOME/.asdf/completions $fpath)

autoload -Uz compinit
() {
  local dump=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION
  [[ -d ${dump:h} ]] || mkdir -p ${dump:h}

  local -a fresh=(${dump}(#qN.mh-24))
  if (( $#fresh )); then
    compinit -C -d $dump
  else
    compinit -d $dump
    { zcompile -R -- ${dump}.zwc $dump } &!
  fi
}

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
: ${LS_COLORS:=di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34}
export LS_COLORS

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' special-dirs true

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=auto $realpath'
zstyle ':fzf-tab:complete:(cat|bat|nvim|vim|less):*' fzf-preview 'bat --color=always --style=plain --line-range=:200 $realpath 2>/dev/null || cat $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
