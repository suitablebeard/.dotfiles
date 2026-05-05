function! ExecFile()
    let executables = {
        \ 'lua': 'lua54',
        \ 'python': 'python',
        \ 'javascript': 'node',
        \ 'sh': 'bash',
        \ }

    if !has_key(executables, &filetype)
        echo 'No executable for filetype: ' . &filetype
        return
    endif

    execute 'vert rightb terminal ' . executables[&filetype] . ' %'
endfunction
