return {
    {
        -- obsidian
        'obsidian-nvim/obsidian.nvim',
        version = '*',
        lazy = true,
        ft = 'markdown',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'saghen/blink.cmp',
            -- 'hrsh7th/nvim-cmp'
        },
        opts = {
            legacy_commands = false,
            notes_subdir = '+',
            new_notes_location = 'notes_subdir',
            completion = {
                min_chars = 0,
            },
            workspaces = {
                {
                    name = 'Vault',
                    path = vim.env.OBSIDIAN_VAULT,
                },
            },
            -- ui = { enable = false },
        },
    },
    {
        -- pretty markdown
        'MeanderingProgrammer/render-markdown.nvim',
        enabled = false,
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    },
    {
        -- markdown preview
        'iamcco/markdown-preview.nvim',
        enabled = false,
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && npm install',
        keys = {},
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    },
}
