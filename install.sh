#!/bin/bash

# ===== Symbolic links I've created so far =====

ln -s ./bash/.bashrc          ~/
ln -s ./vim/.vimrc            ~/
ln -s ./nvim/*                ~/.config/nvim/
ln -s ./.stylua.toml          ~/

# ===== Useful commands I've had to use =====

# make git ignore file wihtout removing it from repo
# the file was causing issue since it is for windows and doesn't work on linux
git update-index --skip-worktree bash/windows-terminal-split-in-cwd.sh && rm bash/windows-terminal-split-in-cwd.sh

