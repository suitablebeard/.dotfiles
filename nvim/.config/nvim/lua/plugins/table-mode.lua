return {
    'dhruvasagar/vim-table-mode',
    enabled = false,
    config = function()
        vim.g.table_mode_motion_up_map = 'tt['
        vim.g.table_mode_motion_down_map = 'tt]'
        vim.g.table_mode_motion_left_map = 't['
        vim.g.table_mode_motion_right_map = 't]'

        -- workaround trying to remap ALT+k
        vim.g.table_mode_eval_formula_map = '<Char-230>'
    end,
}
