-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  -- empty setup using defaults
  require("nvim-tree").setup()

  -- OR setup with some options
  require("nvim-tree").setup({
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })
require('telekasten').setup({
  home = vim.fn.expand("~/docs/notes/notes-daily"), -- Put the name of your notes directory here
})
