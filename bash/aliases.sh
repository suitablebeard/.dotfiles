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

alias lua='lua54'

alias gp='git push'
alias gtt='git status'
alias gl='git log --oneline'
alias gc='git commit -m'
gac() {
  git add . && git commit -m "$*"
}
