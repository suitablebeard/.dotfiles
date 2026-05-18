" ========================
" ==== For my scripts ====
" ========================
" executes current file according to filetype
nnoremap <silent> <leader>x :call ExecFile(fnamemodify(expand('%'), ':p'))<CR>

" Obsidian-wikilinks
let g:obsidian_wikilinks_default_dir = '~/Documents/Obsidian/'            " set default folder for obisidian_wikilinks plugin

" =============================
" ==== Third-party Plugins ====
" =============================
" HightlightedYank
let g:highlightedyank_highlight_duration = 250

" Fugitive
nnoremap <leader>0g :0G<CR>|                                              " open fugitive's status

" Fuzzbox
let g:fuzzbox_preview = 0
let g:fuzzbox_window_options = { 'highlights': { 'preview': 1 } }
let g:fuzzbox_dropdown = 1
let g:fuzzbox_compact = 1

" Gitgutter
let g:gitgutter_sign_priority = 5
let g:gitgutter_close_preview_on_escape = 1

" AutoPairs
let g:AutoPairsMapBS = 0
let g:AutoPairsMapCR = 0

" Table-mode
let g:table_mode_motion_up_map = 'tt['
let g:table_mode_motion_down_map = 'tt]'
let g:table_mode_motion_left_map = 't['
let g:table_mode_motion_right_map = 't]'
let g:table_mode_eval_formula_map = '<Char-230>'|                         " workaround trying to remaps ALT+k

" UltiSnips
let g:UltiSnipsExpandTrigger="<C-0>"

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
