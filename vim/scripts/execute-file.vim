function! ExecFile()
    if &modified
        silent write
    endif

    let s:origin = bufnr('%')

    let s:cmd = s:FindExecutableCmd()
    if s:cmd == -1
        echo 'No executable for filetype: ' . &filetype
        return
    endif

    let s:terminal_buf = s:FindExecTerminal()
    if s:terminal_buf != -1
        execute 'bdelete ' .. s:terminal_buf
    endif

    execute 'vert rightb terminal ' . s:cmd
    execute 'vert resize ' .. float2nr(&columns * 0.2)

    let b:exec_term_buf = 1

    call s:GoBackToExecutedFile(s:origin)

    return
endfunction

function! s:FindExecutableCmd()
    let s:executables = {
        \ 'lua': 'lua54',
        \ 'python': 'python',
        \ 'javascript': 'node',
        \ 'sh': 'bash',
        \ }

    if !has_key(s:executables, &filetype)
        return -1
    endif
    
    return s:executables[&filetype] . ' %'
endfunction

function! s:FindExecTerminal()
    for bufnr in tabpagebuflist()
        if getbufvar(bufnr, 'exec_term_buf', 0)
            return bufnr
        endif
    endfor

    return -1
endfunction

function! s:GoBackToExecutedFile(bufNum)
    call win_gotoid(bufwinid(a:bufNum))
    return
endfunction
