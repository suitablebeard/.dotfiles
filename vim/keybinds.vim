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
nnoremap <leader>x :call ExecFile()<CR>|         " executes current file according to filetype

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
nnoremap <leader>H <C-w>h|                       " goes to window on the left
nnoremap <leader>L <C-w>l|                       " goes to window on the right
nnoremap <leader>J <C-w>j|                       " goes to window bellow
nnoremap <leader>K <C-w>k|                       " goes to window above
nnoremap <leader>< <C-w><|                       " make window narrower
nnoremap <leader>> <C-w>>|                       " make window wider
nnoremap <leader>- <C-w>-|                       " make window shorter
nnoremap <leader>= <C-w>+|                       " make window taller

" Disables arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

