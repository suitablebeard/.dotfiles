return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                -- This is **NOT** Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                if client and client:supports_method('textDocument/inlayHint', event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        -- Enable the following language servers || @type table<string, vim.lsp.Config>
        local servers = {
            -- pyright = {},
            -- tsc = {},
            ts_ls = {},
            cssls = {},
            bashls = {},

            -- Special Lua Config, as recommended by neovim help docs
            lua_ls = {
                on_init = function(client)
                    -- Disable formatting (formatting is done by stylua)
                    client.server_capabilities.documentFormattingProvider = false

                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
                    client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = { 'lua/?.lua', 'lua/?/init.lua' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                    })
                end,
                ---@type lspconfig.settings.lua_ls
                settings = {
                    Lua = {
                        -- Disable formatting (formatting is done by stylua)
                        format = { enable = false },
                    },
                },
            },
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            -- You can add other tools here that you want Mason to install
            'stylua',
            'shellcheck',
            'prettierd',
        })

        require('mason-lspconfig').setup({ automatic_enable = true })
        require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

        for name, server in pairs(servers) do
            vim.lsp.config(name, server)
            vim.lsp.enable(name)
        end

        -- Diagnostic Config & Keymaps
        vim.diagnostic.config({
            update_in_insert = false,
            severity_sort = true,
            float = { border = 'rounded', source = 'if_many' },
            underline = { severity = { min = vim.diagnostic.severity.ERROR } },

            signs = false,
            virtual_lines = false,
            virtual_text = { source = 'if_many' },

            jump = {
                -- Auto open the float, so you can easily read the
                -- errors when jumping with `[d` and `]d`
                on_jump = function(_, bufnr)
                    vim.diagnostic.open_float({
                        bufnr = bufnr,
                        scope = 'cursor',
                        focus = false,
                    })
                end,
            },
        })

        vim.keymap.set('n', '<leader>gq', vim.diagnostic.setloclist, { desc = '[G]o to [Q]uickfix diagnostic list' })
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = '[G]o to [L]ine diagnostic (floating)' })
    end,
}
