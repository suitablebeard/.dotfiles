return {
    'stevearc/conform.nvim',
    keys = {
        {
            '<leader>ft',
            function()
                require('conform').format({ async = true })
            end,
            mode = { 'n', 'v' },
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            local ignored_filetypes = {}

            if vim.tbl_contains(ignored_filetypes, vim.bo[bufnr].filetype) then
                return nil
            end

            return { timeout_ms = 500 }
        end,
        default_format_opts = {
            lsp_format = 'fallback',
        },
        -- You can also specify external formatters in here.
        formatters_by_ft = {
            -- rust = { 'rustfmt' },
            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use 'stop_after_first' to run the first available formatter from the list
            -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
    },
}
