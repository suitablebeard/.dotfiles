" Add your custom folder to the beginning of the runtime path
let &rtp = expand('~/.vim') . ',' . &rtp

set nocompatible
let g:netrw_list_hide= '.*\.swp$'
let g:netrw_dirhistmax = 0   

set encoding=utf-8
set fileencoding=utf-8

set clipboard=unnamed
set guicursor=a:block
set noshowmode
set showcmd " shows the (partial) command as it's being typed
set laststatus=2
set vb t_vb= " removes the flash or audio when reaching the end of a line 
set wildmenu

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

set title
set cursorline

syntax on
set number
set relativenumber
set noshowmatch
set scrolloff=9999
set linebreak


