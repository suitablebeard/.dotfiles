-------------------
---   Layout   ----
-------------------

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
vim.o.signcolumn = 'yes'
vim.opt.scrolloff = 999
vim.opt.relativenumber = true
vim.opt.guicursor = {
    "n-v-c-sm:block",
    "i-ci-ve:block",
    "r-cr-o:hor20",
    "t:block-blinkon500-blinkoff500-TermCursor",
}

vim.opt.showmode = false

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.g.have_nerd_font = true
vim.g.markdown_fenced_languages = {
    'json',
    'javascript',
    'css',
}

-------------------
--- Search Opts ---
-------------------

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-------------------
--- Formatting ----
-------------------

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.linebreak = true

--- writing setup ---
local writing_setup = vim.api.nvim_create_augroup("WritingSetup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = writing_setup,
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.wrap = true
        vim.opt_local.breakindent = true

        if vim.bo.filetype ~= "gitcommit" then
            vim.opt_local.colorcolumn = ""
        end
    end,
})

-------------------
---   Others    ---
-------------------

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt:append('menuone')
vim.opt.completeopt:append('fuzzy')
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.confirm = true

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

-- Diagnostic Config & Keymaps
vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float {
                bufnr = bufnr,
                scope = 'cursor',
                focus = false,
            }
        end,
    },
}
