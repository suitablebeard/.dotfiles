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

alias gp='git push && git push --tags'
alias gtt='git status'
alias gll='git log --color=always --graph --pretty=format:"%C(auto)%h %C(reset)%s %C(auto)%d" --date=short | less -R'
alias glp='git log --color=always --graph --pretty=format:"%C(auto)%h %C(blue)%ad %C(reset)%s %C(brightblack)(%an)%C(auto)%d" --date=short | less -R'
alias gff='git diff'
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
