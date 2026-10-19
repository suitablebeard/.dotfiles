-- General

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('n', 'R', '<C-r>')
vim.keymap.set('v', '<Enter>', '<Esc>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "gJ", ":join<CR>", { silent = true, desc = "Join selected lines without spaces" })

vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('x', '<leader>s', function()
    vim.cmd('normal! y')
    local selected = vim.fn.getreg('"')
    local escaped = vim.fn.escape(selected, [[/\]])
    local cmd = ':%s/' .. escaped .. '/' .. escaped .. '/gI<Left><Left><Left>'
    local cmd_to_populate = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.fn.feedkeys(cmd_to_populate, 'n')
end, {
    desc = 'Substitute visually selected text throughout file',
})

vim.keymap.set("x", "I", function()
    return vim.fn.mode() == "V" and "^<C-v>I" or "I"
end, { expr = true, desc = "Prepend to selection in line-visual mode" })

vim.keymap.set("x", "A", function()
    return vim.fn.mode() == "V" and "$<C-v>A" or "A"
end, { expr = true, desc = "Append to selection in line-visual mode" })

-- Centralizing cursor
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Buffers
vim.keymap.set('n', '<leader>h', vim.cmd.bprevious)
vim.keymap.set('n', '<leader>l', vim.cmd.bnext)
vim.keymap.set('n', '<leader>bd', vim.cmd.bdelete)
vim.keymap.set('n', '<leader>v', vim.cmd.vnew)

-- Windows
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<Up>',    '<C-w>+')
vim.keymap.set('n', '<Down>',  '<C-w>-')
vim.keymap.set('n', '<Left>',  '<C-w><')
vim.keymap.set('n', '<Right>', '<C-w>>')
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Others
vim.keymap.set('n', '<leader>cd', vim.cmd.Ex)
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>')

-- Obsidian
vim.keymap.set('n', '<leader>om', function()
    local final_path = string.format("%s/Atlas/Notes/%s", vim.env.OBSIDIAN_VAULT, vim.fn.fnamemodify(vim.fn.expand('%'), ':t'))
    local file_exists = vim.fn.filereadable(final_path) == 1

    if file_exists then
        vim.api.nvim_echo({ { 'Error: a file already exists in `Atlas/Notes`.', 'WarningMsg' } }, true, {})
        return
    end

    vim.cmd(string.format("!mv '%s' '%s'", vim.fn.expand('%'), final_path))
end)

-- Popups
-- inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
-- inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
-- nnoremap <expr> <BS> !empty(popup_list()) ? "\<C-c>" : "\<BS>"
