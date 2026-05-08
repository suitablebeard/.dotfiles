let lspOpts = #{
    \   autoHighlightDiags: v:true,
    \   diagSignErrorText: '✘',
    \   diagSignWarningText: '▲',
    \   diagSignInfoText: '»',
    \   diagSignHintText: '⚑',
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
    \ ]


autocmd User LspSetup call LspAddServer(lspServers)
autocmd User LspSetup call LspOptionsSet(lspOpts)

augroup lsp_mappings
" Only remaps for languages with a server registered
    au! | autocmd User LspAttached call s:on_lsp_attached()
augroup END

function! s:on_lsp_attached() abort
    nnoremap gd :LspGotoDefinition<CR>
    nnoremap gr :LspShowReferences<CR>
    nnoremap K  :LspHover<CR>
    nnoremap gl :LspDiag current<CR>
    nnoremap <F2> :LspRename<CR>
    nnoremap <F3> :LspFormat<CR>
    nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
    nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>
    inoremap <silent> <C-Space> <C-x><C-o>
endfunction

