return {
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
        {'<leader>0g', '<cmd>0G<CR>'},
        {'<leader>gl', '<cmd>G log --oneline<CR>'}
    },
    config = function()
        vim.api.nvim_create_user_command('Gl', 'G log --oneline', {})
    end,
}
