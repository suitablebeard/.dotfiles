augroup formatter
  autocmd!
  autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.html,*.css call s:format()
augroup END

function! s:format()
  if executable('prettier') && &modified
    normal! m`
    silent %!prettier --stdin-filepath % --tab-width 4
    normal! ``
  endif
endfunction
