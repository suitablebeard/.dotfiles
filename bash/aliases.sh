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

alias dot='cd ~/.dotfiles && vim .'
alias cdcode='cd ~/Documents/myFiles/Programming'

# ======================
# ==== More Aliases ====
# ======================

alias v='vim'
alias vi='vim'
alias vg='vim +0G'
vimplug() {
    local target="${@:-.}"
    vim "$target" +PlugClean +wqa && \
    vim +PlugInstall +wqa && \
    vim "$target"
}

# Use single quotes so $OBSIDIAN_VAULT is evaluated when run, 
# not when the terminal starts (avoids order-of-sourcing bugs).
alias oo='cd $OBSIDIAN_VAULT && vim .'
alias oi='cd $OBSIDIAN_VAULT && cd ./\+ && vim .'
on() {
    if [ $# -eq 0 ]; then
        cd $OBSIDIAN_VAULT && vim . -c "call feedkeys(':ObsidianNewNote ', 'n')"
    else
        cd $OBSIDIAN_VAULT && vim . -c "ObsidianNewNote $*"
    fi
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

