-- General

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('v', '<Enter>', '<Esc>')
vim.keymap.set('n', '<leader>cd', vim.cmd.Ex)
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

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
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Popups
-- vim.keymap.set('i', <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
-- vim.keymap.set('n', <expr> <BS> !empty(popup_list()) ? "\<C-c>" : "\<BS>"
-- vim.keymap.set('i', <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
-- vim.keymap.set('i', <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
