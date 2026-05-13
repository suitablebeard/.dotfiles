" Colorscheme
let g:highlightedyank_highlight_duration = 250

" Obsidian-wikilinks
let g:obsidian_wikilinks_default_dir = '~/Documents/Obsidian/'            " set default folder for obisidian_wikilinks plugin

" Fuzzbox
let g:fuzzbox_preview = 0
let g:fuzzbox_dropdown = 1
let g:fuzzbox_compact = 1

" Airline
augroup formatAirlineZSection                                             " fix weird default formatting of airline's z-section
    autocmd User AirlineAfterInit  call AirlineInit()
augroup END
function! AirlineInit()
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.colnr = '⌗'
    let g:airline_section_z = '%#__accent_bold#%p%%' . ' '
    let g:airline_section_z .= '%l/%L%{g:airline_symbols.linenr}'
    let g:airline_section_z .= '%c%{g:airline_symbols.colnr}%#__restore__#'
endfunction
