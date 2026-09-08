#!/bin/bash

# =====================
# ====  Utilities  ====
# =====================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias files='explorer'

alias ls='ls --color=auto'
alias ll='ls --color=auto -la'
alias cls='clear'
alias grep='grep --color=auto'
alias so='source ~/.bashrc'

alias dot='cd ~/.dotfiles && $EDITOR .'
alias cdcode='cd ~/myFiles/Programming'

# ======================
# ==== VIM Aliases ====
# ======================

alias v.='$EDITOR .'
alias v='$EDITOR'
alias vi='$EDITOR'
alias nv='nvim'

vg() {
    "$EDITOR" -c "autocmd VimEnter * call feedkeys(g:mapleader . \"0g\")"
}

vimplug() {
    local target="${@:-.}"
    vim "$target" +PlugClean +wqa && \
    vim +PlugInstall +wqa && \
    vim "$target"
}

# ========================
# ==== OBSIDIAN VAULT ====
# ========================

# Use single quotes so $OBSIDIAN_VAULT is evaluated when run,
# not when the terminal starts (avoids order-of-sourcing bugs).
alias coo='cd $OBSIDIAN_VAULT'
alias oo='cd $OBSIDIAN_VAULT && $EDITOR .'
alias foo='cd $OBSIDIAN_VAULT && $EDITOR -c "autocmd VimEnter * call feedkeys(g:mapleader . \"of\")"'
alias ooi='cd $OBSIDIAN_VAULT && cd ./\+ && $EDITOR .'

on() {
    # Creates new note in $OBSIDIAN_VAULT
    ~/.dotfiles/bash/scripts/parse-obsidian-newnote-name.sh "$*"
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

