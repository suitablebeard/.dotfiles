#!/bin/bash

# =====================
# ====  Utilities  ====
# =====================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='ls --color=auto'
alias ll='ls --color=auto -la'
alias cls='clear'
alias grep='grep --color=auto'
alias so='source ~/.bashrc'


# ======================
# ==== More Aliases ====
# ======================

alias v='vim'
alias vi='vim'
alias vg='vim +0G'
alias lua='lua54'
alias cdcode='cd ~/Documents/myFiles/Programming'
alias obs='cd ~/Documents/Obsidian/ && vim . +FuzzyFiles'
vimplug() {
    local target="${@:-.}"
    vim "$target" +PlugClean +wqa && \
    vim +PlugInstall +wqa && \
    vim "$target"
}

# =====================
# ==== Git Aliases ====
# =====================

alias ga='git add'
alias gap='git add -p'
alias gp='git push && git push --tags'
alias gtt='git status -s'
alias gttt='git status'
alias ggt='gtt'
alias gll='git log --color=always --graph --pretty=format:"%C(auto)%h %C(reset)%s %C(auto)%d" --date=short | less -R'
alias glp='git log --color=always --graph --pretty=format:"%C(auto)%h %C(blue)%ad %C(reset)%s %C(brightblack)(%an)%C(auto)%d" --date=short | less -R'
alias gck='git checkout'
alias gch='git switch'
alias gsh='git stash'
alias gpp='git stash pop'
alias gff='git diff'
alias gffs='git diff --staged'
alias gres='git restore --stage'

gc() {
    if [ -z "$*" ]; then
        echo "Usage: gc \"commit message\""
        return 1
    fi
    git commit -m "$*"
}
gac() {
    if [ -z "$*" ]; then
        echo "Usage: gac \"commit message\""
        return 1
    fi
    git add . && git commit -m "$*"
}

