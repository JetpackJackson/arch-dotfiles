local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, opts)
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  --"folke/which-key.nvim",
  --{ "folke/neoconf.nvim", cmd = "Neoconf" },
  --"folke/neodev.nvim",
  "JetpackJackson/farin-colors",
  "nvim-neorg/neorg",
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  --{'do', cmd = "TSUpdate"},
  --"rktjmp/lush.nvim",
  "neoclide/coc.nvim",
  { "neoclide/coc.nvim", branch = "release" },
})

--vim.cmd [[colorscheme dusche]]
vim.cmd("colorscheme dusche")

--if has('termguicolors')
--	set termguicolors
--endif

--function! PrintBuffer()
--  silent execute '!lpoptions -d HP_LaserJet_2200_LOCAL_hpcups'
--  silent execute 'w !lp -n 1 -o media=a4 -o sides=two-sided-long-edge -'
--endfunction
--
--
--command! Ha call PrintBuffer()
--command! Hardcopy call PrintBuffer()
--function! PrintBufferWithCR()
--  silent execute 'w !lp'
--endfunction
--
--command! Hc call PrintBufferWithCR()
--
require("neorg").setup({
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.ui"] = {},
    ["core.ui.calendar"] = {},
    ["core.export.markdown"] = {},
    ["core.export"] = {},
    ["core.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = "$XDG_DOCUMENTS_DIR/notes",
          deutsch = "$XDG_DOCUMENTS_DIR/deutsch",
        },
      },
    },
  },
})

-- Bone layout rebinding, with hands on jkl/ (nrsk) to prevent conflicts with
-- g on home row causing delays and stuff
vim.keymap.set("n", "h", "<Leader>ex1")
vim.keymap.set("r", "j", "<Leader>ex1")
vim.keymap.set("s", "k", "<Leader>ex1")
vim.keymap.set("k", "l", "<Leader>ex1")
--noremap n h
--noremap r j
--noremap s k
--noremap k l

vim.keymap.set("h", "n", "<Leader>ex1")
vim.keymap.set("H", "N", "<Leader>ex1")
--noremap h n
--noremap H N
----noremap gg <Nop>
----noremap g <Nop>
----noremap G <Nop>

--remap replace
--noremap ß r
vim.keymap.set("ß", "r", "<Leader>ex1")

--noremap k j|noremap <C-w>k <C-w>j|noremap <C-w><C-k> <C-w>j
--noremap j k|noremap <C-w>j <C-w>k|noremap <C-w><C-j> <C-w>k
