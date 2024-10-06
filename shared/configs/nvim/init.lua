vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

--require("lazy").setup("plugins",{{ "sainnhe/sonokai" }})
require("lazy").setup("plugins",{})
--    {
--    "nvim-treesitter/nvim-treesitter",
--    build = ":TSUpdate",
--    config = function ()
--      local configs = require("nvim-treesitter.configs")
--      configs.setup({
--        require'nvim-treesitter.configs'.setup {
--          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "bash" },
--          sync_install = false,
--          auto_install = true,
--          highlight = {
--            enable = true,
--            disable = { "markdown", "tex" },
--            additional_vim_regex_highlighting = false,
--          },
--        }
--      })
--    end
--    },
----    {
----    'Wansmer/langmapper.nvim',
----    lazy = false,
----    priority = 1, -- High priority is needed if you will use `autoremap()`
----    config = function()
----      require('langmapper').setup({require("config.langmap")})
----    end,
----    },
--})

require("config.keymaps")
require("config.options")
require("user.functions")
-- TODO: consolidate this into one call?
require("plugins.snips.tex")
require("plugins.snips.tex_math")
require("plugins.snips.cpp")
require("plugins.snips.lua")
require("plugins.snips.cmake")
require("plugins.snips.python")
require("user.python")
vim.cmd([[filetype plugin on]])
vim.opt.list = true
vim.opt.listchars = { tab = "⇥ ", leadmultispace = "┊ ", trail = "␣", nbsp = "⍽" }

-- alternative setup
--vim.opt.listchars = {
--    tab = "⟩ ",
--    trail = "+",
--    precedes = "<",
--    extends = ">",
--    space = "·",
--    nbsp = "␣",
--}
--local function update_lead()
--    local lcs = vim.opt_local.listchars:get()
--    local tab = vim.fn.str2list(lcs.tab)
--    local space = vim.fn.str2list(lcs.multispace or lcs.space)
--    local lead = {tab[1]}
--    for i = 1, vim.bo.tabstop-1 do
--        lead[#lead+1] = space[i % #space + 1]
--    end
--    vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })
--end
--vim.api.nvim_create_autocmd("OptionSet", { pattern = { "listchars", "tabstop", "filetype" }, callback = update_lead })
--vim.api.nvim_create_autocmd("VimEnter", { callback = update_lead, once = true })

vim.opt.syntax = "on"
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

vim.opt.equalalways = false
vim.opt.background = "dark"
vim.opt.clipboard:append("unnamedplus")
vim.opt.conceallevel = 2

vim.cmd.colorscheme("sonokai")
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.laststatus = 2 --originally 3
vim.o.number = true
vim.o.relativenumber = true
--vim.cmd([[autocmd InsertEnter * :set norelativenumber]])
--vim.cmd([[autocmd InsertLeave * :set relativenumber]])
-- two lines
--vim.o.statuscolumn = "%s %l %r "
vim.o.shiftwidth = 4
vim.o.signcolumn = "number"
vim.o.smarttab = true
vim.o.softtabstop = 4
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.wo.number = true

-- lua status line
Statusline = {}
Statusline.active = function()
  return table.concat {
    "%#Grey#",
    Update_mode_colors(),
    Mode(),
    "%#StatusLineExtra# ",
    "%{v:lua.Filepath()}",
    Filename(),
    "%=",
    "%#StatusLineExtra#",
    Words(),
    "%=",
    "%#StatusLineExtra#",
    FileEncoding(),
    "%=",
    Filetype(),
    "%=",
    "%#StatusLineExtra#",
    Lineinfo(),
  }
end
function Statusline.inactive()
  return " %F"
end
function Statusline.short()
  return "%#StatusLineNC#"
end
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)


-- files and compilers
vim.cmd([[ let g:fzf_vim = {} ]])
vim.cmd([[ let g:fzf_vim.preview_window = 'right,50%' ]])
vim.cmd([[ let g:fzf_vim.command_prefix = 'Fzf' ]])
vim.cmd([[ let g:pipe2eval_map_key = "`" ]])

vim.cmd([[ command! -bang -nargs=? -complete=dir FzfFiles
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0) ]])

vim.cmd([[
    filetype plugin indent on
    syntax enable
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_compiler_method = 'latexmk'
"    let g:vimtex_view_forward_search_on_start
"    let maplocalleader = ","
]])

vim.g.vimtex_compiler_latexmk = {
  options = {
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode'
  }
}

vim.cmd([[
let g:lf_change_cwd = 0
]])
-- 0 is no changing

vim.cmd([[
let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }
]])

-- markdown code block highlighting
vim.cmd([[
let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript']
]])

--vim.cmd([[ let g:vimspector_enable_mappings = 'HUMAN' ]])
--
require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you still want to use netrw.
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    --"icon",
    "permissions",
    --"size",
    --"type",
    --"mtime",
    {"mtime", highlight = "Comment"},
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = false,
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = true,
  -- Oil will automatically delete hidden buffers after this delay
  -- You can set the delay to false to disable cleanup entirely
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = false,
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "editable",
  -- Set to true to watch the filesystem for changes and reload oil
  experimental_watch_for_changes = false,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<Right>"] = "actions.select",
    ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in a horizontal split" },
    ["<S-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["<Left>"] = "actions.parent",
    ["gg"] = "actions.open_cwd",
    ["q"] = "actions.cd",
    ["t"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Sort file names in a more intuitive order for humans. Is less performant,
    -- so you may want to set to false if you work with large directories.
    natural_order = true,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- Extra arguments to pass to SCP when moving/copying files over SSH
  extra_scp_args = {},
  -- EXPERIMENTAL support for performing file operations with git
  git = {
    -- Return true to automatically git add/mv/rm files
    add = function(path)
      return false
    end,
    mv = function(src_path, dest_path)
      return false
    end,
    rm = function(path)
      return false
    end,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the actions floating preview window
  preview = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating SSH window
  ssh = {
    border = "rounded",
  },
  -- Configuration for the floating keymaps help window
  keymaps_help = {
    border = "rounded",
  },
})
vim.opt.splitright = true
