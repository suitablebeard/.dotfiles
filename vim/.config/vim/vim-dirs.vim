let &rtp = expand('~/.vim') . ',' . &rtp         " add custom runtime path folder
let g:netrw_list_hide= '.*\.swp$'                " hides swap files from netrw
let g:netrw_dirhistmax = 0                       " disables netrw directories history

" Save your backups to a less annoying place
if isdirectory($HOME . '/.vim/backups') == 0
  :silent !mkdir -p ~/.vim/backups >/dev/null 2>&1
endif
set backupdir=~/.vim/backups//
set backupdir+=./tmp//
set backup

" Save your swp files to a less annoying place
if isdirectory($HOME . '/.vim/swaps') == 0
  :silent !mkdir -p ~/.vim/swaps >/dev/null 2>&1
endif
set directory=~/.vim/swaps//
set directory+=~/tmp//

" This allows you to use undos after exiting and restarting
if isdirectory($HOME . '/.vim/undos') == 0
    :silent !mkdir -p ~/.vim/undos > /dev/null 2>&1
endif
set undodir=~/.vim/undos//
set undofile
