return {
    'saghen/blink.cmp',
    enabled = true,
    version = '1.*',
    dependencies = {
        'saghen/blink.lib', -- required only for blink.cmp v2 users
        'bydlw98/blink-cmp-env',
    },
    opts = {
        keymap = { preset = 'default' },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            -- By default, you may press `<c-space>` to show the documentation.
            -- Optionally, set `auto_show = true` to show the documentation after a delay.
            documentation = { auto_show = false, auto_show_delay_ms = 500 },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'env' },
            providers = {
                path = { opts = { show_hidden_files_by_default = true } },
                env = {
                    name = 'Env',
                    module = 'blink-cmp-env',
                    --- @type blink-cmp-env.Options
                    opts = {
                        -- item_kind = require('blink.cmp.types').CompletionItemKind.Variable,
                        item_kind = 6, -- HACK: it can't find the types module; idk why tho
                        show_braces = false,
                        show_documentation_window = true,
                    },
                },
            },
        },
        snippets = { preset = 'luasnip' },
        fuzzy = { implementation = 'lua' },
        signature = { enabled = true },
    },
}
