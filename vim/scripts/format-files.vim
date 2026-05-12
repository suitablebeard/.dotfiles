filetype plugin indent on                        " checks filetype and handles indentation
set expandtab                                    " tabs becomes spaces when typing
set shiftwidth=4                                 " num of spaces for indentation
set softtabstop=4                                " num spaces when delete a tab
set tabstop=4                                    " sets size for existing tab character in spaces
set autoindent                                   " copies indentation from previous line
set smartindent                                  " adds basic language-aware indentation (like inside {})
set backspace=indent,eol,start                   " fixes backspace behavior in insert mode


let prettier_cmd = 'prettier --tab-width 4 --single-quote --stdin-filepath %'
let lua_cmd = 'luafmt --stdin %'
augroup formatter
    autocmd!
    autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.json,*.html,*.css,*.md call s:format('prettier', prettier_cmd)
    autocmd BufWritePre *.lua call s:format('luafmt', lua_cmd)
augroup END

function! s:format(formatter, cmd) abort
    if !(executable(a:formatter) && &modified)
        return
    endif

    normal! m`
    execute 'silent! %!' . a:cmd
    normal! ``
endfunction
