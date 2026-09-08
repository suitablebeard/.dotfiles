" ========================
" ==== For my scripts ====
" ========================
" executes current file according to filetype
nnoremap <silent> <leader>x :call ExecFile(fnamemodify(expand('%'), ':p'))<CR>

" vim-obsidian
let g:obsidian_vault_dir = $OBSIDIAN_VAULT
let g:obsidian_newfile_dir = $OBSIDIAN_VAULT .. '/+'

let move_note_cmd = printf("!mv '%s' '%s/Atlas/Notes'", expand('%'), $OBSIDIAN_VAULT)
nnoremap <leader>om :execute move_note_cmd<CR>

nnoremap <leader>of :FuzzyFindNotes<CR>
nnoremap <leader>og :FuzzyGrepNotes<CR>

command! FuzzyFindNotes call fuzzbox#Launch('files', #{ cwd: expand($OBSIDIAN_VAULT), title: 'Find Notes' })
command! FuzzyGrepNotes call fuzzbox#Launch('grep', #{ cwd: expand($OBSIDIAN_VAULT), title: 'Grep Notes' })

" =============================
" ==== Third-party Plugins ====
" =============================
" HightlightedYank
let g:highlightedyank_highlight_duration = 250

" Fugitive
nnoremap <silent> <leader>0g :0G<CR>|                                              " open fugitive's status

" Fuzzbox
let g:fuzzbox_preview = 0
let g:fuzzbox_window_options = { 'highlights': { 'preview': 1 } }

" Gitgutter
let g:gitgutter_sign_priority = 5
let g:gitgutter_close_preview_on_escape = 1

" Table-mode
let g:table_mode_motion_up_map = 'tt['
let g:table_mode_motion_down_map = 'tt]'
let g:table_mode_motion_left_map = 't['
let g:table_mode_motion_right_map = 't]'
let g:table_mode_eval_formula_map = '<Char-230>'|                         " workaround trying to remap ALT+k

" UltiSnips
let g:UltiSnipsExpandTrigger="<C-0>"

" NerdTree
nnoremap <leader>n :NERDTreeFocus<CR>
augroup NerdTreeConf
    autocmd!
    autocmd BufEnter * call CloseNerdTreeWhenLastWindow()

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * {
        if argc() == 0 && !exists('s:std_in')
            NERDTree
            wincmd p
        elseif argc() > 0 && !isdirectory(argv()[0])
            NERDTree
            wincmd p
        endif
    }
augroup END

function! CloseNerdTreeWhenLastWindow()
    if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()
        call feedkeys(":quit\<CR>:\<BS>")
    endif
endfunction

" Airline
augroup formatAirlineZSection                                             " fix weird default formatting of airline's z-section
    autocmd!
    autocmd User AirlineAfterInit  call AirlineInit()
augroup END
function! AirlineInit()
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.colnr = '⌗'
    let g:airline_section_z = '%#__accent_bold#%p%%' . ' '
    let g:airline_section_z .= '%l/%L%{g:airline_symbols.linenr}'
    let g:airline_section_z .= '%c%{g:airline_symbols.colnr}%#__restore__#'
endfunction
