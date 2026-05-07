#!/bin/bash

export GIT_PS1_SHOWDIRTYSTATE=1      # shows * or + for dirty repo
export GIT_PS1_SHOWSTASHSTATE=1      # shows $ if stash exists
export GIT_PS1_SHOWUNTRACKEDFILES=1  # shows % if untracked files
export GIT_PS1_SHOWUPSTREAM=""   # shows ahead/behind


# Add blank between command runs
last_cmd=""
PROMPT_COMMAND='
current_cmd=$(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//")
if [[ "$current_cmd" != "$last_cmd" ]]; then
    [[ ! "$current_cmd" =~ ^(clear|reset|cls)$ ]] && echo
fi
last_cmd="$current_cmd"
'

# Custom PS1
GREEN="\[\e[32m\]"
BLUE="\[\e[34m\]"
YELLOW="\[\e[33m\]"
CYAN="\[\e[36m\]"
RESETCOLOR="\[\e[0m\]"

PS1=""
PS1+="${GREEN}\u@\h${RESETCOLOR} " # username@host
PS1+="${YELLOW}\$(short_path)${RESETCOLOR}" # path
PS1+="${CYAN}\$(__git_ps1 ' (%s)')${RESETCOLOR}" # git branch
PS1+=" \$ " # prompt symbol

short_path() {
  local p="$PWD"

  # replace home path with ~
  case "$p" in
    "$HOME"*) p="~${p#$HOME}" ;;
  esac

  IFS="/" read -ra parts <<< "$p"
  local n=${#parts[@]}

  if (( n <= 2 )); then
    echo "$p"
  else
    echo "${parts[n-2]}/${parts[n-1]}"
  fi
}

is_git_dirty() {
    git diff --no-ext-diff --quiet || echo "*"
    git diff --no-ext-diff --cached --quiet || echo "+"
}

parse_git_branch() {
  branch=$(git branch 2>/dev/null | grep "*" | sed -E "s/^\* \(?|\)$//g")
  if [ -n "$branch" ]; then
      echo " ($branch$(is_git_dirty))"
  fi
}
