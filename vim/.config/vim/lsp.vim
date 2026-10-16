vim9script

var lspOpts = {
    autoHighlightDiags: true,
    diagSignErrorText: '■',
    diagSignWarningText: '■',
    diagSignInfoText: '■',
    diagSignHintText: '■',
    showDiagWithVirtualText: true,
    diagVirtualTextAlign: 'after',
    diagVirtualTextWrap: 'wrap',
    highlightDiagInline: false,
    showDiagWithSign: false,
    usePopupInCodeAction: true,
    ultisnipsSupport: true,
}

var npmPath = $HOME .. '\AppData\Roaming\npm\'
var lspServers = [
    {
        name: 'lua-language-server',
        filetype: ['lua'],
        path: 'C:\Program Files\lua-language-server-3.18.2\bin\lua-language-server',
    },
    {
        name: 'typescript-language-server',
        filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
        path: npmPath .. 'typescript-language-server.cmd',
        args: ['--stdio'],
    },
    {
        name: 'bash-language-server',
        filetype: ['sh'],
        path: npmPath .. 'bash-language-server.cmd',
        args: ['start'],
    },
    {
        name: 'vim-language-server',
        filetype: ['vim'],
        path: npmPath .. 'vim-language-server.cmd',
        args: ['--stdio'],
        features: { diagnostics: false }
    },
]

var foundServers = []
for server in lspServers
    if getftype(server['path']) == ''
        var msg = $'LSP server not found: {fnameescape(server['path'])}'
        execute $'autocmd VimEnter * ++once echohl WarningMsg | echomsg "{msg}" | echohl None'
        continue
    endif

    add(foundServers, server)
endfor

if len(foundServers) == 0
    finish
endif

autocmd User LspSetup g:LspAddServer(foundServers)
autocmd User LspSetup g:LspOptionsSet(lspOpts)

augroup LspSetup 
    # Only triggered for languages with a server registered
    autocmd!
    autocmd User LspAttached LspMappings() | set completeopt+=fuzzy
augroup END

def LspMappings()
    nnoremap <buffer> gd :LspGotoDefinition<CR>
    nnoremap <buffer> gr :LspShowReferences<CR>
    nnoremap <buffer> K  :LspHover<CR>
    nnoremap <buffer> [d :LspDiag prev<CR>
    nnoremap <buffer> ]d :LspDiag next<CR>
    nnoremap <buffer> <leader>gl :LspDiagCurrent<CR>
    nnoremap <buffer> <F3> :LspFormat<CR>
    nnoremap <buffer> <leader>vrn :LspRename<CR>
    nnoremap <buffer> <leader>vca :LspCodeAction<CR>
    inoremap <buffer> <silent> <C-Space> <C-\><C-o>:call lsp#completion#LspComplete(true)<CR>

    # Customize colors ofdiagnostics display on the screen
    highlight link LspDiagVirtualTextHint MoreMsg
    highlight LspDiagVirtualTextInfo guifg=#a6da95
    highlight LspDiagVirtualTextWarning guifg=#eed49f
    highlight LspDiagVirtualTextError guifg=#ed8796
enddef

