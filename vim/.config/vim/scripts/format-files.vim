let s:prettier_cmd = 'prettier --tab-width 4 --single-quote --stdin-filepath %'
let s:lua_cmd = 'luafmt --stdin %'

augroup formatter
    autocmd!
    autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.json,*.html,*.css call s:format('prettier', s:prettier_cmd)
    autocmd BufWritePre *.lua call s:format('luafmt', s:lua_cmd)
augroup END

function! s:format(formatter, cmd) abort
    if !(executable(a:formatter) && &modified)
        return
    endif

    normal! m`
    execute 'silent! %!' . a:cmd
    normal! ``
endfunction
