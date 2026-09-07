return {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
        if vim.g.have_nerd_font then
           require('mini.icons').setup()
            MiniIcons.mock_nvim_web_devicons()
        end

        require('mini.ai').setup {
            -- NOTE: Avoid conflicts with the built-in incremental selection mappings
            --       on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
            mappings = {
                around_next = 'aa',
                inside_next = 'ii',
            },
            n_lines = 500,
        }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        require('mini.surround').setup()

        require('mini.pairs').setup()

        -- Simple and easy statusline.
        local statusline = require 'mini.statusline'
        statusline.setup { use_icons = vim.g.have_nerd_font }
        statusline.section_location = function() return '%2l:%-2v' end
    end
}
