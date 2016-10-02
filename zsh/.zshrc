# zgen loading
zgen_remote="https://github.com/tarjoilija/zgen"
zgen_home="$HOME/.zgen"
[ ! -d "$zgen_home" ] && git clone "$zgen_remote" "$zgen_home"
export ZGEN_DIR="$zgen_home"
source "$zgen_home/zgen.zsh"
unset zgen_remote zgen_home

# custom completition path
fpath=(~/.zsh/completion $fpath)

if ! zgen saved; then
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src
  zgen load subnixr/minimal
  zgen save
fi

autoload -U compinit

# keep 1000 lines of history within the shell and save it to ~/.zsh_history:
 histsize=100000
 savehist=100000
HISTFILE=~/.zsh_history
compinit

# no history duplicates
# setopt INC_APPEND_HISTORY
# setopt SHARE_HISTORY
# setopt EXTENDED_HISTORY
# setopt HIST_IGNORE_DUPS

# case insensitive completition
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export GREP_COLOR="0;32"

# colored man
export LESS_TERMCAP_mb=$(printf "\e[0;34m")
export LESS_TERMCAP_md=$(printf "\e[0;34m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[0;32m")

# syntax highlight
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=green'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=green'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=green'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=green'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=blue'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='underline'
ZSH_HIGHLIGHT_STYLES[path_approx]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=green'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
export ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS

# python virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=true

# VIMODE
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
#bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M vicmd 'k' history-beginning-search-backward

# enable run-help
bindkey -M vicmd 'K' run-help

export KEYTIMEOUT=1


# ALIASES
alias ls="ls --color=auto"
alias l="ls -lah"
alias rf="rm -r"
alias grep="grep --color=auto"
#alias vim="nvim"

alias pdb="python3 -m pdb"

# git
alias gst='git status -s'
alias gc='git commit'
alias gcm='git commit -m'
alias ga='git add'

# git flow
alias gffs="git flow feature start"
alias gfff="git flow feature finish"

# tmux
alias tmuxa="tmux-wrap attach"
alias tmuxn="tmux-wrap new"
alias tmuxd="tmux-wrap new-detach"
alias tmuxk="tmux kill-session -t"
alias tmuxl="tmux list-session -F #S"

# glsl
alias glslv="glslViewer"

# xclip -> pbcopy
if [ -e "$(which xclip)" ]; then
    alias pbcopy="xclip -selection c -i"
    alias pbpaste="xclip -selection c -o"
fi

# history
alias history="cat $HISTFILE | cut -c 16-"

# TMUX HELPER
function tmux-wrap(){
  local cmd="$1"
  local dir="$(realpath ${2:-$(pwd)})"
  local name="${$(basename "$dir")//[.]/}"

  case "$cmd" in
    attach)
      tmux attach || tmux new -s"$name" -c"$dir"
      ;;
    new)
      tmux new -s"$name" -c"$dir"
      ;;
    new-detach)
      tmux new -d -s"$name" -c"$dir"
      ;;
  esac
}


# PYTHON VENV WRAPPER
[ -n "$VIRTUAL_ENV" ] && source "$VIRTUAL_ENV/bin/activate"
[ -z "$VENV_HOME" ] && VENV_HOME="$HOME/.virtualenvs"

function mkvenv(){
  type deactivate &> /dev/null && deactivate
  local name="$1"
  # TODO: pass other arguments ($@)
  virtualenv "$VENV_HOME/$name"
  source "$_/bin/activate"
}

function workon(){
  type deactivate &> /dev/null && deactivate
  local name="$1"
  source "$VENV_HOME/$name/bin/activate"
}

function lsvenv(){
  local opt 
  local OPTIND
  local flag="-x" 
  while getopts ":l" opt; do
    case $opt in
      l)
        flag="-1"
        ;;
    esac
  done
  ls $flag --color=never "$VENV_HOME"
}

function rmvenv(){
  local name="$1"
  rm -rf "$VENV_HOME/$name"
}
