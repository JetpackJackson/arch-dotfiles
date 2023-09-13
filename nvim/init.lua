vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<F1>', ':Startify<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F2>', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F3>', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', ':Telekasten find_daily_notes<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', ':Lazy<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gn', ':Gitsigns next_hunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gp', ':Gitsigns prev_hunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true })

require("config.lazy")
--.setup({})
--require("keymaps")
-- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true
  vim.cmd.colorscheme("gruvbox")



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
      home = vim.fn.expand("~/docs/notes/notes-daily/"),
    },
    lectures = {
      home = vim.fn.expand("~/docs/notes/school/"),
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
require('lualine').setup {
  options = {
    --icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
local navic = require("nvim-navic")

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "bash" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
local ts_utils = require 'nvim-treesitter.ts_utils'

--require("config")

vim.cmd("set noequalalways")
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.opt.signcolumn = "number"
vim.cmd("set cursorline")
vim.cmd([[
    let s:header_cmd = 'fortune deutsch | cowsay -W 80'
    let g:startify_custom_header = startify#pad(split(system(s:header_cmd), '\n'))]])
--#center is centered, #pad is padded
