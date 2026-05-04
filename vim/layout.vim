set title                                        " changes terminal's tab title 
set cursorline                                   " highlights current line cursor is in
syntax on                                        " syntax highlighting (e.g. comments, variables, etc)
set number                                       " shows line number
set relativenumber                               " shows how distant a line is from you
set noshowmatch                                  " disables jump to pair character like ) or ]
set scrolloff=9999                               " makes cursor stay in the center
set nowrap                                       " no linewrapping as the default
set linebreak                                    " ensures linewrapping won't happen mid-word
set guicursor=a:block                            " ensures cursus is always block
set vb t_vb=                                     " removes the flash or audio when reaching the end of a line 
set showcmd                                      " shows the (partial) command as it's being typed
set noshowmode                                   " hides default mode display (e.g. -- insert --)
set laststatus=2                                 " shows status line (wiht file info, etc)

" Turns linewrapping on for text (e.g. .txt, .md, etc)
" and adds indentation for wrapped line
augroup wrapForText
    autocmd!
    autocmd FileType markdown,text,gitcommit setlocal wrap breakindent
augroup END
