" There's a pipe character after every command for the inline comments
" otherwise vim would also read the space characters until the commnet

let mapleader = " "|                                                 " sets space as the leader key

" Utility
inoremap kj <Esc>|                                                   " exits insert mode with 'kj'
nnoremap Q <nop>|                                                    " disable Ex mode
vnoremap <space> <Esc>|                                              " exits visual mode with space
nnoremap <silent> <Esc> :noh<CR>|                                    " removes highlights after a search
nnoremap <silent> <leader>no :noh<CR>|                               " removes highlights after a search

nnoremap <leader>so :so ~/.vimrc<CR>|                                " sources the vimrc

nnoremap <silent> <leader>cd :Ex<CR>|                                " opens netwr (vim's file explorer)
xnoremap <leader>p "_dP|                                             " ensures to not lose copied text when pasting
xnoremap <expr> I mode() ==# 'V' ? '^<C-v>I' : 'I'|                  " prepends text to multiple lines in v-line mode
xnoremap <expr> A mode() ==# 'V' ? '$<C-v>A' : 'A'|                  " appends text to multiple lines in v-line mode

" Centralizing cursor
nnoremap J mzJ`z|                                                    " ensures cursor stays inplace when joining multiple lines
nnoremap <C-d> <C-d>zz|                                              " centers screen when up by half-page
nnoremap <C-u> <C-u>zz|                                              " centers screen when down by half-page
nnoremap n nzzzv|                                                    " centers screen when searching forward
nnoremap N Nzzzv|                                                    " centers screen when searching backward

" Saving and quitting the file
nnoremap <leader>w :w<CR>|                                           " saves files
nnoremap <leader><leader>w :wq<CR>|                                  " saves and quits file
nnoremap <leader>q :q<CR>|                                           " quits file
nnoremap <leader>qa :qa<CR>|                                         " quits file
nnoremap <leader><leader>q :q!<CR>|                                  " force quits file
nnoremap <leader><leader>qa :qa!<CR>|                                " force quits file

" Buffers
nnoremap <silent> <leader>h :bprevious<CR>|                          " goes to previous buffer
nnoremap <silent> <leader>l :bnext<CR>|                              " goes to next buffer
nnoremap <leader>bd :bdelete<CR>|                                    " delete buffer
nnoremap <leader>v :vnew<CR>|                                        " opens empty buffer in vertical split (on the left)

" Windows
nnoremap <leader><leader>h <C-w>h|                                   " goes to window on the left
nnoremap <leader><leader>l <C-w>l|                                   " goes to window on the right
nnoremap <leader><leader>j <C-w>j|                                   " goes to window bellow
nnoremap <leader><leader>k <C-w>k|                                   " goes to window above
noremap <Up>    <C-w>+|                                              " make window taller
noremap <Down>  <C-w>-|                                              " make window shorter
noremap <Left>  <C-w><|                                              " make window narrower
noremap <Right> <C-w>>|                                              " make window wider

" Popups
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"|            " enables tab in autocomplete menu
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"|        " enables tab in autocomplete menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"|              " enables enter in autocomplete menu
nnoremap <expr> <BS> !empty(popup_list()) ? "\<C-c>" : "\<BS>"|      " closes popup with <backspace> (for lsp)

" ---------------- CONFLICT WITH Autopairs plugin ----------------
" cancels autocomplete suggestion with <backspace>
" inoremap <expr> <Esc> pumvisible() ? '\<C-e>' : '\<Esc>'|              
" ---------------- CONFLICT WITH Autopairs plugin  ----------------

" == For my scripts ==
nnoremap <silent> <leader>x :call ExecFile()<CR>|                    " executes current file according to filetype

" ======= For plugins =======
" Fugitive
nnoremap <leader>0g :0G<CR>|                                          " open fugitive's status

" Table-mode
let g:table_mode_motion_up_map = 'tt['
let g:table_mode_motion_down_map = 'tt]'
let g:table_mode_motion_left_map = 't['
let g:table_mode_motion_right_map = 't]'
let g:table_mode_eval_formula_map = '<Char-230>'|                     " workaround trying to remaps ALT+k
