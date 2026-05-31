call plug#begin('~/.vim/plugged')

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'

Plug 'machakann/vim-highlightedyank'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree'

Plug 'yegappan/lsp'
Plug 'pangloss/vim-javascript'
Plug 'tbastos/vim-lua'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'vim-fuzzbox/fuzzbox.vim'

" Useful language related snippets (ultisnips is the engine)
Plug 'Sirver/ultisnips' | Plug 'honza/vim-snippets'

" Improve md tables experince
Plug 'dhruvasagar/vim-table-mode'

" =============== My own Plugins and Forks===============
" Uncomment these lines in case you don't have them locally
Plug '~/myFiles/Programming/vim-obsidian'

" Plug 'suitablebeard/vim-obsidian'

call plug#end()

