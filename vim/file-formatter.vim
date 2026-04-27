augroup formatter
    autocmd!
    autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.html,*.css,*.md call s:format()
augroup END

function! s:format()
    if !(executable('prettier') && &modified)
        return
    endif

    normal! m`
    silent %!prettier --stdin-filepath % --tab-width 4 --single-quote 
    normal! ``
endfunction
