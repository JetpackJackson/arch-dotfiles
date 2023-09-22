local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup("plugins",{
--  '0x00-ketsu/markdown-preview.nvim',
--  ft = {'md', 'markdown', 'mkd', 'mkdn', 'mdwn', 'mdown', 'mdtxt', 'mdtext', 'rmd', 'wiki'},
--  config = function()
--    require('markdown-preview').setup {
--      -- your configuration comes here
--      -- or leave it empty to use the default settings
--      -- refer to the setup section below
--    }
--  end



--  "namrabtw/rusty.nvim",
--  version = false,
--  lazy = false,
--  priority = 1000, -- make sure to load this before all the other start plugins
--

--  {'Iron-E/nvim-highlite',
--    config = function(_, opts)
--      -- OPTIONAL: setup the plugin. See "Configuration" for information
--      require('highlite').setup {generator = {plugins = {vim = false}, syntax = false}}
--
--      -- or one of the alternate colorschemes (see the "Built-in Colorschemes" section)
--      vim.api.nvim_command 'colorscheme highlite'
--    end,
--    lazy = false,
--    priority = math.huge,
--    version = '^4.0.0',
--  },


--require("lazy").setup({
--  spec = {
--    -- add LazyVim and import its plugins
----    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
--    { import = "plugins" },
--  },
--  defaults = {
--    lazy = false,
--    version = false, -- always use the latest git commit
----    -- version = "*", -- try installing the latest stable version for plugins that support semver
--  },
--  checker = { enabled = true }, -- automatically check for plugin updates
--  performance = {
--    rtp = {
--      -- disable some rtp plugins
--      disabled_plugins = {
--        "gzip",
--        -- "matchit",
--        -- "matchparen",
--        -- "netrwPlugin",
--        "tarPlugin",
--        "tohtml",
--        -- "tutor",
--        "zipPlugin",
--      },
--    },
--  },
})

require("config.keymaps")
--require("config.cmp")
require("config.colorscheme")
require("config.options")
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")





require('telekasten').setup({
  home = vim.fn.expand("~/docs/notes/notes-daily"), -- Put the name of your notes directory here
  vaults = {
--    dailynotes = {
--      home = vim.fn.expand("~/docs/notes/notes-daily/"),
--    },
    circuits = {
      home = vim.fn.expand("~/docs/notes/school/EEL3111C/lectures/"),
    },
    programming = {
      home = vim.fn.expand("~/docs/notes/school/EEL3834/lectures/"),
    },
    intro = {
      home = vim.fn.expand("~/docs/notes/school/EEL3000/lectures/"),
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

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.cursorline = true
vim.cmd("set noequalalways")
vim.cmd([[
    let s:header_cmd = 'fortune deutsch | cowsay -W 80'
    let g:startify_custom_header = startify#pad(split(system(s:header_cmd), '\n'))
    let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.lua'}, {'n': '~/docs/notes/notes-daily/'} ]

    "function s:foobar()
    "return [
    "      \ { 'line': 'nvim', 'cmd': 'cd ~/.config/nvim/lua' },
    "      \ ]
    "endfunction
    
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
    autocmds = {
        enableOnVimEnter = true,
    },
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
require('telescope').load_extension('media_files')
-- requires chafa
require'telescope'.setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      -- find command (defaults to `fd`)
      find_cmd = "rg"
    }
  },
}

--require('lsp-toggle').setup()
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

--local function escape(str)
--  -- You need to escape these characters to work correctly
--  local escape_chars = [[;,."|\]]
--  return vim.fn.escape(str, escape_chars)
--end
--
---- Recommended to use lua template string
--local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
--local de = [[8jduaxphlmwß8ctieobnrsgqfvüäöyz]]
--local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
--local de_shift = [[8JDUAXPHLMWẞ„CTIEOBNRSGQFVÜÄÖYZ–•]]
--
--vim.opt.langmap = vim.fn.join({
--    -- | `to` should be first     | `from` should be second
--    escape(de_shift) .. ';' .. escape(en_shift),
--    escape(de) .. ';' .. escape(en),
--}, ',')
