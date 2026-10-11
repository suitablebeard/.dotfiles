return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
            -- 'saadparwaiz1/cmp_luasnip',
        },
        opts = {
            version = vim.version.range('2.*'),
        },
        config = function(_, opts)
            require('luasnip').setup(opts)
            require('luasnip.loaders.from_vscode').lazy_load()
        end,
    },
}
