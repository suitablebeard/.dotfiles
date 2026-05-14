let lspOpts = #{
    \   autoHighlightDiags: v:true,
    \   diagSignErrorText: '■',
    \   diagSignWarningText: '■',
    \   diagSignInfoText: '■',
    \   diagSignHintText: '■',
    \   showDiagWithVirtualText: v:true,
    \   diagVirtualTextAlign: 'after',
    \   diagVirtualTextWrap: 'wrap',
    \   highlightDiagInline: v:false,
    \   showDiagWithSign: v:false,
    \   usePopupInCodeAction: v:true,
    \   ultisnipsSupport: v:true,
    \ }

let s:npmPath = expand('~\AppData\Roaming\npm\')
let lspServers = [
    \    #{
    \         name:'lua-language-server',
    \         filetype:['lua'],
    \         path:'C:\Program Files\lua-language-server-3.18.2\bin\lua-language-server',
    \    },
    \    #{
    \   	  name: 'typescript-language-server',
    \   	  filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
    \   	  path: s:npmPath . 'typescript-language-server.cmd',
    \   	  args: ['--stdio'],
    \    },
    \    #{
    \         name:'bash-language-server',
    \         filetype:['sh'],
    \   	  path: s:npmPath . 'bash-language-server.cmd',
    \   	  args: ['start'],
    \    },
    \    #{
    \         name:'vim-language-server',
    \         filetype:['vim'],
    \   	  path: s:npmPath . 'vim-language-server.cmd',
    \   	  args: ['--stdio'],
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
    nnoremap <buffer> [d :LspDiag prev<CR>
    nnoremap <buffer> ]d :LspDiag next<CR>
    nnoremap <buffer> <F3> :LspFormat<CR>
    nnoremap <buffer> <leader>vrn :LspRename<CR>
    nnoremap <buffer> <leader>vca :LspCodeAction<CR>
    inoremap <buffer> <silent> <C-Space> <C-\><C-o>:call lsp#completion#LspComplete(v:true)<CR>

    " Customize colors ofdiagnostics display on the screen
    highlight link LspDiagVirtualTextHint MoreMsg
    highlight LspDiagVirtualTextInfo guifg=#a6da95
    highlight LspDiagVirtualTextWarning guifg=#eed49f
    highlight LspDiagVirtualTextError guifg=#ed8796
endfunction

