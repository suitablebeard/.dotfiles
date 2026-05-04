augroup formatter
    autocmd!
    autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.html,*.css,*.md call s:format('prettier', 'prettier --stdin-filepath % --tab-width 4 --single-quote ')
    autocmd BufWritePre *.lua call s:format('luafmt', 'luafmt --stdin %')
augroup END

function! s:format(formatter, cmd) abort
    if !(executable(a:formatter) && &modified)
        return
    endif

    normal! m`
    execute 'silent %!' . a:cmd
    normal! ``
endfunction
