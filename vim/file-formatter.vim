" Uses Prettier to format some file types
augroup formatter
    autocmd!
    autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.html,*.css,*.md call s:prettierFormat()
augroup END

function! s:prettierFormat()
    if !(executable('prettier') && &modified)
        return
    endif

    normal! m`
    silent %!prettier --stdin-filepath % --tab-width 4 --single-quote 
    normal! ``
endfunction
