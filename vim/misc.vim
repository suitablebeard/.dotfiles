" Enconding
set nocompatible                                 " turns off compatibility with VI (vim's antecessor) 
set encoding=utf-8                               " vim's internal enconding
set fileencoding=utf-8                           " encoding of files when saved to disk

" Searching with /
set hlsearch                                     " highlights all matches
set incsearch                                    " highlights as you type
set ignorecase                                   " searches are case insensitive
set smartcase                                    " enforces case sensitivity for capital letters (e.g. /Foo)
set shortmess-=S                                 " shows num of matches when searching

" Others
set clipboard=unnamed                            " use system clipboard
set wildmenu                                     " better command-line autocomplete in vim

set completeopt=menuone                          " improves the autocompletion menu
set completeopt+=noinsert
set completeopt+=noselect
set completeopt+=popup
set completeopt+=fuzzy
