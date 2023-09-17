vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<F1>', ':Startify<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F2>', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F3>', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', ':Telekasten find_daily_notes<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', ':Lazy<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>h', ':Startify<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fd', ':Telekasten find_daily_notes<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>la', ':Lazy<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':TodoLocList<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NoNeckPain<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fi', ':Telekasten search_notes<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':Mason<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':Telekasten switch_vault<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>lt', ':NoNeckPain<CR>|<C-w><Left>|:terminal<CR>i', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>e', ':ToggleLSP<CR>', { noremap = true })

vim.cmd([[tnoremap <Esc> <C-\><C-n>]])


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
--  {{"shortcuts/no-neck-pain.nvim", version = "*"}}
  spec = {
    -- add LazyVim and import its plugins
--    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        -- "tutor",
        "zipPlugin",
      },
    },
  },
})


--require("config.lazy")
--.setup({})
--require("keymaps")
-- disable netrw at the very start of your init.lua
--  vim.g.loaded_netrw = 1
--  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true
  vim.cmd.colorscheme("gruvbox")

--require("lazy").setup({{"shortcuts/no-neck-pain.nvim", version = "*"}})


--require("nvim-tree").setup({
--  sort = {
--    sorter = "case_sensitive",
--  },
--  view = {
--    width = 30,
--  },
--  renderer = {
--    group_empty = true,
--  },
--  filters = {
--    dotfiles = true,
--  },
--})

require('telekasten').setup({
  home = vim.fn.expand("~/docs/notes/notes-daily"), -- Put the name of your notes directory here
  vaults = {
    dailynotes = {
      home = vim.fn.expand("~/docs/notes/notes-daily/"),
    },
    circuits = {
      home = vim.fn.expand("~/docs/notes/school/EEL3111C/lectures/"),
    },
    programming = {
      home = vim.fn.expand("~/docs/notes/school/EEL3834/lectures/"),
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

require('hologram').setup{
    auto_display = false -- WIP automatic markdown image display, may be prone to breaking
}

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
--local navic = require("nvim-navic")
--
--require("lspconfig").clangd.setup {
--    on_attach = function(client, bufnr)
--        navic.attach(client, bufnr)
--    end
--}

--require'lspconfig'.pyright.setup{}
--require'lspconfig'.clangd.setup{}
--
--
--require'lspconfig'.lua_ls.setup {
--  on_init = function(client)
--    local path = client.workspace_folders[1].name
--    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
--      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
--        Lua = {
--          runtime = {
--            -- Tell the language server which version of Lua you're using
--            -- (most likely LuaJIT in the case of Neovim)
--            version = 'LuaJIT'
--          },
--          -- Make the server aware of Neovim runtime files
--          workspace = {
--            checkThirdParty = false,
--            library = {
--              vim.env.VIMRUNTIME
--              -- "${3rd}/luv/library"
--              -- "${3rd}/busted/library",
--            }
--            -- or pull in all of 'runtimepath'. this is a lot slower
--            -- library = vim.api.nvim_get_runtime_file("", true)
--          }
--        }
--      })
--
--      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--    end
--    return true
--  end
--}



require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "bash" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  --ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
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


--vim.o.noequalalways = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.cursorline = true
--vim.s.header_cmd = "fortune deutsch | cowsay -W 80"
--vim.g.startify_custom_header = "startify#pad(split(system(s:header_cmd), '\n'))"

vim.cmd("set noequalalways")
--vim.cmd("set shiftwidth=4")
--vim.cmd("set softtabstop=4")
--vim.cmd("set number")
--vim.cmd("set relativenumber")
--vim.opt.signcolumn = "number"
--vim.cmd("set cursorline")
vim.cmd([[
    let s:header_cmd = 'fortune deutsch | cowsay -W 80'
    let g:startify_custom_header = startify#pad(split(system(s:header_cmd), '\n'))
    let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.lua'}, {'n': '~/docs/notes/notes-daily/'} ]

    function s:foobar()
    return [
          \ { 'line': 'nvim', 'cmd': 'cd ~/.config/nvim/lua' },
          \ ]
    endfunction
    
    "let s:bookmarks1 = ['foo', '~/.config/nvim/init.lua']
    let s:bookmarks2 = ['~/docs/notes/notes-daily/', '~/docs/notes/school/EEL3111C/lectures/']

    let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '.getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU' ]           },
      "\ { 'type': function('s:foobar'), 'header': ['   cd nvim/lua'] },
      "\ {'header': ['   Files'],   'type': {-> map(s:bookmarks1, '{"line": v:val, "path": v:val}')}},
      \ {'header': ['   Folders'], 'type': {-> map(s:bookmarks2, '{"line": v:val, "path": v:val}')}},
      "\ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      "\ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
    ]])
--#center is centered, #pad is padded

require("no-neck-pain").setup({
    buffers = {
        left = {
            enabled = true,
        },
        right = {
--            scratchPad = {
--            -- set to `false` to
--            -- disable auto-saving
--            enabled = true,
--            -- set to `nil` to default 
--            -- to current working directory
--            location = "nil",
--            --location = "~/docs/notes/notes-daily/",
--            },
--            bo = {
--                filetype = "md"
--            },
        },
    },
})

--require('lsp-toggle').setup()
