-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true
  vim.cmd.colorscheme('gruvbox')

--  require("lazy.nvim").setup({
--    deps = { "sainnhe/gruvbox" },
--    opts = {
--      colorscheme = "gruvbox",
--    }
--  })

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
  vaults = {
    dailynotes = {
      home = "~/docs/notes/notes-daily/",
    },
    lectures = {
      home = "~/docs/notes/lectures/",
    },
  },
  auto_set_filetype = false,
  -- integrate with calendar-vim
	plug_into_calendar = true,
	calendar_opts = {
		-- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
		weeknm = 4,
		-- use monday as first day of week: 1 .. true, 0 .. false
		calendar_monday = 0,
		-- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
		calendar_mark = "left-fit",
	},
})
--require('mini.starter').setup()
--require('startify').setup({startify_custom_header_quotes = startify#fortune#predefined_quotes() + [['quote 1', 'quote 2']]})
