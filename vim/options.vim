" Layout
set nocompatible                                 " turns off compatibility with VI (vim's antecessor)
colorscheme catppuccin_macchiato                 " sets colorscheme
syntax on                                        " syntax highlighting (e.g. comments, variables, etc)
set title                                        " changes terminal's tab title
set cursorline                                   " highlights current line cursor is in
set number                                       " shows line number
set relativenumber                               " shows how distant a line is from you
set noshowmatch                                  " disables jump to pair character like ) or ]
set colorcolumn=80
set scrolloff=9999                               " makes cursor stay in the center
set guicursor=a:block                            " ensures cursus is always block
set vb t_vb=                                     " removes the flash or audio when reaching the end of a line
set showcmd                                      " shows the (partial) command as it's being typed
set noshowmode                                   " hides default mode display (e.g. -- insert --)
set laststatus=2                                 " shows status line (wiht file info, etc) [useful for lightline plugin]
set termguicolors                                " enables true color support in vim
set splitright                                   " ensures vertical split ends on the right
set splitbelow                                   " ensures horizontal split ends on the bottom
set pumheight=10                                 " sets maximum height for autocomplete popup
let g:markdown_fenced_languages = [
\   'json',
\   'javascript',
\   'css',
\]

" hides colorcolumn for markdown
augroup unColorColumn
    autocmd!
    autocmd FileType markdown setlocal colorcolumn=
augroup END

" Formatting
filetype plugin indent on                        " checks filetype and handles indentation
set expandtab                                    " tabs becomes spaces when typing
set shiftwidth=4                                 " num of spaces for indentation
set softtabstop=4                                " num spaces when delete a tab
set tabstop=4                                    " sets size for existing tab character in spaces
set autoindent                                   " copies indentation from previous line
set smartindent                                  " adds basic language-aware indentation (like inside {})
set backspace=indent,eol,start                   " fixes backspace behavior in insert mode
set nowrap                                       " no linewrapping as the default
set linebreak                                    " ensures linewrapping won't happen mid-word

" Turns on linewrapping and adds indentation for wrapped line
augroup wrapForText
    autocmd!
    autocmd FileType markdown,text,gitcommit setlocal wrap breakindent
augroup END

" Search options
set nohlsearch                                   " highlights all matches
set incsearch                                    " highlights as you type
set ignorecase                                   " searches are case insensitive
set smartcase                                    " enforces case sensitivity for capital letters (e.g. /Foo)
set shortmess-=S                                 " shows num of matches when searching

" Others
set encoding=utf-8                               " vim's internal enconding
set fileencodings=utf-8,latin1                   " encoding of files when saved to disk

set clipboard=unnamed                            " use system clipboard
set wildmenu                                     " better command-line autocomplete in vim
set updatetime=500                               " faster response from vim-gitgutter plugin
set timeoutlen=400                               " decrease wait time for mapped sequence to complete

set completeopt=menuone                          " improves the autocompletion menu
set completeopt+=noinsert
set completeopt+=noselect
set completeopt+=popup
set completeopt+=fuzzy
