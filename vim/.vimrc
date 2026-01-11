" The code bellow simply sources these vim config files
let s:sourceFiles = [
    \ 'options.vim',
    \ 'centralize-vim-metadata.vim',
    \ 'plugins.vim',
    \ 'keybinds.vim',
    \ 'colors.vim'
    \ ]

for file in s:sourceFiles
    exec 'source' . expand('~/.dotfiles/vim') . '/' . file
endfor

