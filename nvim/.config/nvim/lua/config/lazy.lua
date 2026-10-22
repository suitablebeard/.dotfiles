-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  -- First Open Setup
  vim.fn.mkdir(vim.fn.stdpath("data") .. "site/spell", "p")
  local spell_langs = { 'en', 'pt', 'es', 'fr' }
  for _, lang in ipairs(spell_langs) do
    require('nvim.spellfile').config({ confirm=false })
    require('nvim.spellfile').get(lang)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin-macchiato" } },
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    frequency = 86400,
  },
  change_detection = { notify = false },
})
