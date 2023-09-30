local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup("plugins",{})
require("config.keymaps")
require("config.options")

vim.opt.termguicolors = true
vim.cmd([[set conceallevel=2]])
vim.cmd.colorscheme("gruvbox")
vim.cmd([[set clipboard+=unnamedplus]])
-- Initialize configuration dictionary
vim.cmd([[ let g:fzf_vim = {} ]])
vim.cmd([[
        let g:fzf_vim.preview_window = 'right,50%'
        ]])

vim.cmd([[ command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0) ]])


--vim.cmd([[ command! -bang -nargs=? -complete=dir Circuits
--    \ call fzf#vim#files("$XDG_DOCUMENTS_DIR/notes/school/EEL3111C/lectures", fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0) ]])
--
--
--vim.cmd([[ command! -bang -nargs=? -complete=dir Config
--    \ call fzf#vim#files("$XDG_CONFIG_HOME/nvim", fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)]])

--vim.cmd([[
-- let maplocalleader = "," 
-- let g:tex_flavor='latex'
-- let g:vimtex_view_method='zathura'
-- let g:vimtex_quickfix_mode=0
-- let g:vimtex_compiler_method = 'latexrun'
--" set conceallevel=1
-- let g:tex_conceal='abdmg']])

--require("no-neck-pain").setup({
--	autocmds = {
--	    enableOnVimEnter = true,
--	},
--	buffers = {
--	    left = {
--		enabled = true,
--	    },
--	    right = {
--	    },
--	},
--})

function searchCount()
  local search = vim.fn.searchcount({maxcount = 0}) -- maxcount = 0 makes the number not be capped at 99
  local searchCurrent = search.current
  local searchTotal = search.total
  if searchCurrent > 0 then
    return "/"..vim.fn.getreg("/").." ["..searchCurrent.."/"..searchTotal.."]"
  else
    return ""
  end
end

function MixedIdents()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
     return 'MI:'..mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:'..tab_indent
  else
    return 'MI:'..space_indent
  end
end

function TrailingSpace()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and "TS" or ""
end

--require'lualine'.setup{
--  sections = {
--    lualine_a = {'mode'},
--    lualine_b = {'branch', 'diff', 'diagnostics'},
--    lualine_c = {'filename', {"os.date('%H:%M:%S')"}, {MixedIdents}, {TrailingSpace}},
--    lualine_x = {'lsp_progress',{ searchCount },'encoding', 'fileformat', 'filetype'},
--    lualine_y = {'progress'},
--    lualine_z = {'location'}
--  }
--}

--require('lualine').setup {
--  options = {
--    --icons_enabled = true,
--    theme = 'auto',
--    component_separators = { left = '', right = ''},
--    section_separators = { left = '', right = ''},
--    disabled_filetypes = {
--      statusline = {},
--      winbar = {},
--    },
--    ignore_focus = {},
--    always_divide_middle = true,
--    globalstatus = false,
--    refresh = {
--      statusline = 1000,
--      tabline = 1000,
--      winbar = 1000,
--    }
--  },
--  sections = {
--    lualine_a = {'mode'},
--    lualine_b = {'branch', 'diff', 'diagnostics'},
--    lualine_c = {'filename'},
--    lualine_x = {'encoding', 'fileformat', 'filetype'},
--    lualine_y = {'progress'},
--    lualine_z = {'location'}
--  },
--  inactive_sections = {
--    lualine_a = {},
--    lualine_b = {},
--    lualine_c = {'filename'},
--    lualine_x = {'location'},
--    lualine_y = {},
--    lualine_z = {}
--  },
--  tabline = {},
--  winbar = {},
--  inactive_winbar = {},
--  extensions = {}
--}

--require("zk").setup({
--  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
--  -- it's recommended to use "telescope" or "fzf"
--  picker = "fzf",
--
--  lsp = {
--    -- `config` is passed to `vim.lsp.start_client(config)`
--    config = {
--      cmd = { "zk", "lsp" },
--      name = "zk",
--      -- on_attach = ...
--      -- etc, see `:h vim.lsp.start_client()`
--    },
--
--    -- automatically attach buffers in a zk notebook that match the given filetypes
--    auto_attach = {
--      enabled = true,
--      filetypes = { "markdown" },
--    },
--  },
--})

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
--local ts_utils = require 'nvim-treesitter.ts_utils'

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
    "let s:header_cmd = 'cat ~/zettel-.txt | cowsay -n'
    let g:startify_custom_header = startify#pad(split(system(s:header_cmd), '\n'))
    let g:startify_bookmarks = [ {'a': '$XDG_DOCUMENTS_DIR/notes/notes-zettelkasten/agenda.md'}, {'c': '~/.config/nvim/init.lua'}, {'n': '~/docs/notes/notes-zettelkasten/'} ]

    "function s:foobar()
    "return [
    "      \ { 'line': 'nvim', 'cmd': 'cd ~/.config/nvim/lua' },
    "      \ ]
    "endfunction
    
    "let s:bookmarks1 = ['foo', '~/.config/nvim/init.lua']
    let s:bookmarks2 = ['~/docs/notes/notes-zettelkasten/', '~/docs/notes/school/EEL3111C/lectures/']

    let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '.getcwd()] },
      "\ { 'type': 'files',     'header': ['   MRU' ]           },
      "\ { 'type': function('s:foobar'), 'header': ['   cd nvim/lua'] },
      "\ {'header': ['   Files'],   'type': {-> map(s:bookmarks1, '{"line": v:val, "path": v:val}')}},
      "\ {'header': ['   Folders'], 'type': {-> map(s:bookmarks2, '{"line": v:val, "path": v:val}')}},
      "\ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      "\ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
    ]])
--#center is centered, #pad is padded


