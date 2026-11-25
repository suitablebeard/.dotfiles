return {
    'stevearc/oil.nvim',
    -- Optional dependencies
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    lazy = false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    keys = {
        {
            '-',
            function() require('oil').open_float() end,
            desc = 'Open parent directory in Oil',
        },
    },
    opts = {
        -- See :help oil.skip_confirm_for_simple_edits
        skip_confirm_for_simple_edits = false,
        -- Selecting a new/moved/renamed file or directory
        -- will prompt you to save changes first
        -- See :help prompt_save_on_select_new_entry
        prompt_save_on_select_new_entry = true,
        view_options = { show_hidden = true },
        float = { max_width = 0.8, max_height = 0.8 },
    },
}
