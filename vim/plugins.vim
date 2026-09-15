function! s:FindLocalPlugins(plugins)
    for l:plugin in a:plugins
        for l:path in l:plugin.paths
            if isdirectory(expand(l:path))
                let l:plugin.local_path = expand(l:path)
                break
            endif
        endfor
    endfor

    return a:plugins
endfunction

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

" Improve markdown experience
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/goyo.vim'

" =============== My own Plugins and Forks===============
" Auto installs plugins if you don't have them locally

let s:local_plugins = [ 
\     { 
\         'name': 'vim-obsidian',
\         'github': 'suitablebeard/vim-obsidian',
\         'paths': [
\             '~/myFiles/Programming/vim-obsidian',
\             '~/Projects/vim-obsidian'
\         ],
\         'local_path': '',
\     },
\ ]

let s:parsed_plugins = s:FindLocalPlugins(s:local_plugins)
for s:plugin in s:parsed_plugins
    let s:is_local_plugin = !empty(s:plugin.local_path)
    if s:is_local_plugin
        let s:vimplug_dir = expand('~/.vim/plugged/' . s:plugin.name)

        if isdirectory(s:vimplug_dir)
            call delete(s:vimplug_dir, 'rf')
            echom 'Removed remote plugin copy from ' . s:vimplug_dir 
        endif

        execute 'Plug ' . string(s:plugin.local_path)
    else
        execute 'Plug ' . string(s:plugin.github)
    endif
endfor

call plug#end()

