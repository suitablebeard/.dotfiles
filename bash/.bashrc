# Setting Variables
export VISUAL=vim
export EDITOR=vim
export GIT_EDITOR=vim

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cdcode='cd ~/Documents/myFiles/Programming'

alias ls='ls --color=auto'
alias ll='ls --color=auto -la'
alias cls='clear'
alias grep='grep --color=auto'
alias so='source ~/.bashrc'

alias gp='git push'
alias gcm='git commit -m'
alias gcam='git commit -am'

alias lua='lua54'

# Add blank between command runs
last_cmd=""
PROMPT_COMMAND='
current_cmd=$(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//")
if [[ "$current_cmd" != "$last_cmd" ]]; then
    [[ ! "$current_cmd" =~ ^(clear|reset)$ ]] && echo
fi
last_cmd="$current_cmd"
'

# Customize PS1
GREEN="\[\e[32m\]"
BLUE="\[\e[34m\]"
YELLOW="\[\e[33m\]"
CYAN="\[\e[36m\]"
RESETCOLOR="\[\e[0m\]"

PS1=""
PS1+="${GREEN}\u@\h${RESETCOLOR} " # username@host
PS1+="${YELLOW}\$(short_path)${RESETCOLOR}" # path
PS1+="${CYAN}\$(parse_git_branch)${RESETCOLOR}" # git branch
PS1+=" \$ " # prompt symbol

short_path() {
  local p="$PWD"

  # replace home path with ~
  case "$p" in
    "$HOME"*) p="~${p#$HOME}" ;;
  esac

  IFS='/' read -ra parts <<< "$p"
  local n=${#parts[@]}

  if (( n <= 2 )); then
    echo "$p"
  else
    echo "${parts[n-2]}/${parts[n-1]}"
  fi
}

is_git_dirty() {
  git diff --quiet 2>/dev/null || echo "*"
}

parse_git_branch() {
  branch=$(git branch 2>/dev/null | grep '*' | sed 's/* //')
  if [ -n "$branch" ]; then
      echo " ($branch$(is_git_dirty))"
  fi
}


