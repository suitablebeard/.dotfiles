return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>ft',
            function()
                require('conform').format({ async = true })
            end,
            mode = '',
            desc = 'Format buffer',
        },
    },
    opts = {
        format_on_save = function(bufnr)
            local ignored_filetypes = {}

            if vim.tbl_contains(ignored_filetypes, vim.bo[bufnr].filetype) then
                return nil
            end

            if
                vim.g.disable_autoformat
                or vim.b[bufnr].disable_autoformat
            then
                return
            end

            return { timeout_ms = 500 }
        end,
        default_format_opts = {
            lsp_format = 'fallback',
        },
        -- You can also specify external formatters in here.
        formatters_by_ft = {
            lua = { 'stylua' },
            javascript = {
                'prettierd',
                'prettier',
                stop_after_first = true,
            },
            html = { 'prettierd', 'prettier', stop_after_first = true },
            css = { 'prettierd', 'prettier', stop_after_first = true },
            json = { 'prettierd', 'prettier', stop_after_first = true },
            bash = { 'shfmt' },
            sh = { 'shfmt' },
            -- python = { "isort", "black" },
        },
    },
    init = function()
        vim.api.nvim_create_user_command(
            'ConformFormatDisable',
            function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end,
            {
                desc = 'Disable autoformat-on-save',
                bang = true,
            }
        )

        vim.api.nvim_create_user_command('ConformFormatEnable', function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = 'Re-enable autoformat-on-save',
        })
    end,
}
