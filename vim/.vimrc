" The code bellow simply sources these vim config files
let s:sourceFiles = [
    \ 'options.vim',
    \ 'centralize-vim-metadata.vim',
    \ 'plugins.vim',
    \ 'keybinds.vim',
    \ 'colors.vim',
    \ 'file-formatter.vim',
    \ ]

for file in s:sourceFiles
    let s:escapedFilePath = fnameescape(simplify(expand('~/.dotfiles/vim' . '/' . file)))
    exec 'source ' . s:escapedFilePath
endfor

