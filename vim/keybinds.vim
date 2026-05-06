" There's a pipe character after every command for the inline comments
" otherwise vim would also read the space characters until the commnet

" Miscellaneous
let mapleader = " "|                             " sets space as the leader key

inoremap kj <Esc>|                               " exits insert mode with 'kj'
vnoremap <space> <Esc>|                          " exits visual mode with space
nnoremap <Esc> :noh<CR>|                         " removes highlights after a search

nnoremap <leader>so :so %<CR>|                   " sources the current file
nnoremap <leader>cd :Ex<CR>|                     " opens netwr (vim's file explorer)
nnoremap <leader>v :vnew<CR>|                    " opens empty buffer in vertical split (on the left)
nnoremap <leader>x :call ExecFile()<CR><C-w>h|         " executes current file according to filetype
nnoremap <leader><leader>x <C-w>l:bd<CR>:call ExecFile()<CR><C-w>h|         " executes current file according to filetype

" Motions
nnoremap J mzJ`z|                                " ensures cursor stays inplace when joining lines
nnoremap <C-d> <C-d>zz|                          " centers screen when up by half-page
nnoremap <C-u> <C-u>zz|                          " centers screen when down by half-page
nnoremap n nzzzv|                                " centers screen when searching forward
nnoremap N Nzzzv|                                " centers screen when searching backward
xnoremap <leader>p "_dP|                         " ensures to not lose copied text when pasting

" Saving and quitting the file
nnoremap <leader>w :w<CR>|                       " saves files
nnoremap <leader><leader>w :wq<CR>|              " saves and quits file
nnoremap <leader>q :q<CR>|                       " quits file
nnoremap <leader><leader>q :q!<CR>|              " force quits file

" Move around buffers in a window
nnoremap <leader>h :bprevious<CR>|               " goes to previous buffer
nnoremap <leader>l :bnext<CR>|                   " goes to next buffer
nnoremap <leader>bd :bdelete<CR>|                " delete buffer

" Move around windows
nnoremap <leader><leader>h <C-w>h|               " goes to window on the left
nnoremap <leader><leader>l <C-w>l|               " goes to window on the right
nnoremap <leader><leader>j <C-w>j|               " goes to window bellow
nnoremap <leader><leader>k <C-w>k|               " goes to window above
noremap <Up>    <C-w>+|                          " make window taller
noremap <Down>  <C-w>-|                          " make window shorter
noremap <Left>  <C-w><|                          " make window narrower
noremap <Right> <C-w>>|                          " make window wider

