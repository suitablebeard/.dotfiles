" Miscellaneous
let mapleader = " "

inoremap kj <Esc>
nnoremap <Esc> :noh<CR> " removes highlights after a search

" Saving and quitting the file
nnoremap <leader>w :w<CR> " saves files
nnoremap <leader><leader>w :wq<CR> " saves and quits file
nnoremap <leader>q :q<CR> " quits file
nnoremap <leader><leader>q :q!<CR> " force quits file

nnoremap <leader>so :so %<CR> " sources the current file
nnoremap <leader>cd :Ex<CR> " opens netwr (vim's file explorer)

" Open files
nnoremap <leader>v :vnew<CR>

" Move around buffers in a window
nnoremap <leader>h :bprevious<CR> " goes to previous buffer
nnoremap <leader>l :bnext<CR> " goes to next buffer
nnoremap <leader>bd :bdelete<CR> " delete buffer

" Move around windows
nnoremap <leader>H <C-w>h " goes to window on the left
nnoremap <leader>L <C-w>l " goes to window on the right
nnoremap <leader>J <C-w>j " goes to window bellow
nnoremap <leader>K <C-w>k " goes to window above
nnoremap <leader>< <C-w>< " make window narrower
nnoremap <leader>> <C-w>> " make window wider
nnoremap <leader>- <C-w>- " make window shorter
nnoremap <leader>= <C-w>+ " make window taller

" Disables arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

