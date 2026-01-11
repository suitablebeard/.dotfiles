" Since the runtimepath is is basically ~/.vim it just wouldn't work with how
" I'm setting up my .dotfiles folder; Not sure if there's a better way to do it
" set runtimepath+=~/.dotfiles/.vim

set nocompatible
set clipboard=unnamed

set noshowmode
set showcmd " Show the (partial) command as it's being typed
set laststatus=2
set vb t_vb= " removes the flash or audio when reaching the end of a line 
set wildmenu

let g:netrw_list_hide= '.*\.swp$'
let g:netrw_dirhistmax = 0   

set hlsearch
set ignorecase
set smartcase

filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent

set backspace=indent,eol,start


" Start of Setting The Appearance
set title
set cursorline

syntax on
set number
set relativenumber
set noshowmatch
set scrolloff=9999


