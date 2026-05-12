call plug#begin('~/.vim/plugged')

Plug 'ghifarit53/tokyonight-vim'
Plug 'itchyny/lightline.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'machakann/vim-highlightedyank'
Plug 'jiangmiao/auto-pairs'
Plug 'yegappan/lsp'
Plug 'vim-fuzzbox/fuzzbox.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Useful language related snippets (ultisnips is the engine)
Plug 'Sirver/ultisnips' | Plug 'honza/vim-snippets'

" Improve md tables experince
Plug 'dhruvasagar/vim-table-mode'

" =============== My own Plugins ===============
" Uncomment these lines in case you don't have them locally
Plug '~/Documents/myFiles/Programming/vim-obsidian-wikilinks'

" Plug 'suitablebeard/vim-obsidian-wikilinks'

call plug#end()

