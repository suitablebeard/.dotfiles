#!/usr/bin/env bash

export GIT_PS1_SHOWDIRTYSTATE=1      # shows * or + for dirty repo
export GIT_PS1_SHOWSTASHSTATE=1      # shows $ if stash exists
export GIT_PS1_SHOWUNTRACKEDFILES=1  # shows % if untracked files
export GIT_PS1_SHOWUPSTREAM=""   # shows ahead/behind

COL_RED=$'\033[0;91m'
COL_GREEN=$'\033[32m'
COL_BLUE=$'\033[34m'
COL_YELLOW=$'\033[33m'
COL_CYAN=$'\033[36m'
COL_RESET=$'\033[0m'

__add_line_between_cmds() {
  current_cmd=$(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//")
  [[ ! "$current_cmd" =~ ^(clear|reset|cls)$ ]] && echo
}

__show_exit_code() {
  local exit_code="$?"
  (( exit_code != 0 )) && printf '%s(%d)%s ' "$COL_RED" "$exit_code" "$COL_RESET"
}

__short_pwd() {
  # replace home path with ~
  local current_path="${PWD/#$HOME/\~}"

  IFS="/" read -ra path_segments <<< "$current_path"

  if (( ${#path_segments[@]} <= 2 )); then
    echo "$current_path"
    return
  fi

  echo "${path_segments[-2]}/${path_segments[-1]}"
}

PROMPT_COMMAND="__add_line_between_cmds${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

PS1=""
PS1+="\$(__show_exit_code)" # last cmd's exit code
PS1+="${COL_GREEN}\u@\h${COL_RESET} " # username@host
PS1+="${COL_YELLOW}\$(__short_pwd)${COL_RESET}" # path
PS1+="${COL_CYAN}\$(__git_ps1 ' (%s)')${COL_RESET}" # git branch
PS1+=" \$ " # prompt symbol

