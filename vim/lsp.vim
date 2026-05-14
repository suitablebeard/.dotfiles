let lspOpts = #{
    \   autoHighlightDiags: v:true,
    \   diagSignErrorText: '✘',
    \   diagSignWarningText: '▲',
    \   diagSignInfoText: '»',
    \   diagSignHintText: '⚑',
    \   showDiagWithVirtualText: v:true,
    \   diagVirtualTextAlign: 'after',
    \   highlightDiagInline: v:false,
    \   showDiagWithSign: v:false,
    \   usePopupInCodeAction: v:true,
    \   ultisnipsSupport: v:true,
    \ }

let npmPath = $HOME . '\AppData\Roaming\npm\'
let lspServers = [
    \    #{
    \         name: 'typescript-language-server',
    \         filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
    \         path: npmPath . 'typescript-language-server.cmd',
    \         args: ['--stdio'],
    \    },
    \    #{
    \         name:'lua-language-server',
    \         filetype:['lua'],
    \         path:'C:\Program Files\lua-language-server-3.18.2\bin\lua-language-server',
    \    },
    \    #{
    \         name:'bash-language-server',
    \         filetype:['sh'],
    \         path: npmPath . 'bash-language-server.cmd',
    \         args: ['start'],
    \    },
    \    #{
    \         name:'vim-language-server',
    \         filetype:['vim'],
    \         path: npmPath . 'vim-language-server.cmd',
    \         args: ['--stdio'],
    \    },
    \ ]

autocmd User LspSetup call LspAddServer(lspServers)
autocmd User LspSetup call LspOptionsSet(lspOpts)

augroup lsp_mappings
" Only remaps for languages with a server registered
    autocmd!
    autocmd User LspAttached call s:on_lsp_attached()
augroup END

function! s:on_lsp_attached() abort
    nnoremap <buffer> gd :LspGotoDefinition<CR>
    nnoremap <buffer> gr :LspShowReferences<CR>
    nnoremap <buffer> K  :LspHover<CR>
    nnoremap <buffer> gl :LspDiag current<CR>
    nnoremap <buffer> <F2> :LspRename<CR>
    nnoremap <buffer> <F3> :LspFormat<CR>
    nnoremap <buffer> <leader>nd :LspDiag next \| LspDiag current<CR>
    nnoremap <buffer> <leader>pd :LspDiag prev \| LspDiag current<CR>
    inoremap <buffer> <silent> <C-Space> <C-x><C-o>
endfunction

