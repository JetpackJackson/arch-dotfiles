vim.cmd("set noequalalways")
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set number")
vim.cmd("set relativenumber")

require 'eye_candy'
require('gitsigns').setup()
require 'mappings'
require 'plugins'
require 'lsp'
require 'luasnip_cfg'
require 'diagnostic_cfg'
require 'telescope_cfg'
require 'treesitter_cfg'
require 'null-ls_cfg'
require 'nvim-tree_cfg'
