" All this code was taken from the reddit thread bellow:
" https://www.reddit.com/r/vim/comments/40ymts/comment/cyz56ma/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backups') == 0
  :silent !mkdir -p ~/.vim/backups >/dev/null 2>&1
endif
set backupdir=~/.vim/backups//
set backupdir+=./tmp//
set backupdir+=.
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swaps') == 0
  :silent !mkdir -p ~/.vim/swaps >/dev/null 2>&1
endif
set directory=~/.vim/swaps//
set directory+=~/tmp//
set directory+=.

" This is only present in 7.3+ {{{3
if exists('+undofile')
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  if isdirectory($HOME . '/.vim/undos') == 0
    :silent !mkdir -p ~/.vim/undos > /dev/null 2>&1
  endif
  set undodir=~/.vim/undos//
  set undofile
endif
