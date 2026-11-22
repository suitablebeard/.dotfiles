return {
    'saghen/blink.cmp',
    enabled = true,
    version = '1.*',
    dependencies = {
        -- 'saghen/blink.lib', -- required only for blink.cmp v2 users
        'bydlw98/blink-cmp-env',
        'disrupted/blink-cmp-conventional-commits',
    },
    opts = {
        keymap = { preset = 'default' },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            -- By default, you may press `<c-space>` to show the documentation.
            -- Optionally, set `auto_show = true` to show the documentation after a delay.
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
        sources = {
            default = {
                'lsp',
                'path',
                'snippets',
                'buffer',
                'env',
                'conventional_commits',
            },
            providers = {
                path = { opts = { show_hidden_files_by_default = true } },
                env = {
                    name = 'Env',
                    module = 'blink-cmp-env',
                    --- @type blink-cmp-env.Options
                    opts = {
                        -- HACK:
                        -- The original for `item_kind` is:
                        -- item_kind = require('blink.cmp.types').CompletionItemKind.Variable,
                        -- However, for some reason it cannot get the value for the
                        -- completion item of the type `Variable`, making the auto
                        -- completion go completely crazy. And therefore, I'm
                        -- hardcoding the types module value here
                        item_kind = 6,
                        show_braces = false,
                        show_documentation_window = true,
                    },
                },
                conventional_commits = {
                    name = 'Conventional Commits',
                    module = 'blink-cmp-conventional-commits',
                    score_offset = 10,
                    enabled = function()
                        return vim.bo.filetype == 'gitcommit'
                    end,
                    ---@module 'blink-cmp-conventional-commits'
                    ---@type blink-cmp-conventional-commits.Options
                    opts = {
                        -- See Configuration section below for available options
                    },
                },
            },
        },
        snippets = { preset = 'luasnip' },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        signature = { enabled = true },
    },
}
