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
----    {
----    "nvim-treesitter/nvim-treesitter",
----    build = ":TSUpdate",
----    config = function ()
----      local configs = require("nvim-treesitter.configs")
----      configs.setup({
----        require'nvim-treesitter.configs'.setup {
----          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "bash" },
----          sync_install = false,
----          auto_install = true,
----          highlight = {
----            --enable = true,
----            disable = { "markdown", "tex" },
----            additional_vim_regex_highlighting = false,
----          },
----        }
----      })
----    end
----    },
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
--require("user.snips")
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

--vim.cmd("set noequalalways")
--vim.cmd([[set background=dark]])
--vim.cmd([[set clipboard+=unnamedplus]])
--vim.cmd([[set conceallevel=2]])
vim.opt.equalalways = false
vim.opt.background = "dark"
vim.opt.clipboard:append("unnamedplus")
vim.opt.conceallevel = 2

vim.cmd.colorscheme("sonokai")
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.laststatus = 2 --originally 3
vim.o.number = true
--vim.o.relativenumber = true
vim.cmd([[autocmd InsertEnter * :set norelativenumber]])
vim.cmd([[autocmd InsertLeave * :set relativenumber]])
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
--    "%#Statusline#",
    "%#Grey#",
    Update_mode_colors(),
    Mode(),
--    "%#Normal# ",
    "%#StatusLineExtra# ",
    Filepath(),
    Filename(),
    "%=",
    "%#StatusLineExtra#",
  --  "%#Normal#",
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
vim.cmd([[ let g:pipe2eval_map_key = "`" ]])

vim.cmd([[ command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0) ]])

vim.cmd([[
    filetype plugin indent on
    syntax enable
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_compiler_method = 'latexmk'
    let maplocalleader = ","
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
