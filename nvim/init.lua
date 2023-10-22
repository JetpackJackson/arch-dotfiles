vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

--require("lazy").setup({{ "sainnhe/sonokai" }})
require("lazy").setup("plugins",{
    {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        require'nvim-treesitter.configs'.setup {
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "bash" },
          sync_install = false,
          auto_install = true,
          highlight = {
            --enable = true,
            disable = { "markdown", "tex" },
            additional_vim_regex_highlighting = false,
          },
        }
      })
    end
    },
--    {
--    'Wansmer/langmapper.nvim',
--    lazy = false,
--    priority = 1, -- High priority is needed if you will use `autoremap()`
--    config = function()
--      require('langmapper').setup({require("config.langmap")})
--    end,
--    },
})

require("config.keymaps")
require("config.options")
require("user.functions")

vim.cmd([[syntax on]])
vim.opt.list = true
vim.opt.listchars = {
    tab = "⟩ ",
    trail = "+",
    precedes = "<",
    extends = ">",
    space = "·",
    nbsp = "␣",
}
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
--
vim.opt.listchars = { tab = "⇥ ", leadmultispace = "┊ ", trail = "␣", nbsp = "⍽" }

vim.o.laststatus = 2 --originally 3
vim.wo.number = true
vim.o.smarttab = true
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.opt.showmode = false
--vim.opt.cmdheight = 0
--vim.o.statusline = "%F"
--vim.wo.statusline = '%F'
--vim.cmd([[set statusline=%<%f\ %h%m%r\\ 
--set statusline+=%{toupper(g:currentmode[mode()])}\

--%{''.(&fenc!=''?&fenc:&enc).''}

-- vimscript statusline
--vim.cmd([[
--"set statusline=%{luaeval(RedrawModeColors('Mode()'))}
--set statusline+=%<\ %{luaeval('Mode()')}\ 
--set statusline+=%f\ %=%h%m%r\ 
--set statusline+=%{wordcount().words}\ words\ 
--set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
--]])
--vim.cmd([[
--set statusline+=\[%{&fileformat}\]
--set statusline+=%=%-14.(%l,%c%V%)\ %P
--]])

--lua status line
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
  return "%#StatusLineNC#   NvimTree"
end
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

-- colors
vim.cmd([[set background=dark]])
vim.opt.termguicolors = true
vim.cmd([[set conceallevel=2]])
vim.cmd.colorscheme("sonokai")
vim.cmd([[set clipboard+=unnamedplus]])
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.cursorline = true
vim.cmd("set noequalalways")

--local function git_branch()
--    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
--    if string.len(branch) > 0 then
--        return branch
--    else
--        return ":"
--    end
--end
--local function statusline()
--    local set_color_1 = "%#PmenuSel#"
--    local branch = git_branch()
--    local set_color_2 = "%#Fg#"
--    local file_name = " %f"
--    local modified = "%m"
--    local align_right = "%="
--    local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
--    local fileformat = " [%{&fileformat}]"
--    local filetype = " %y"
--    local percentage = " %p%%"
--    local linecol = " %l:%c"
--    return string.format(
--        "%s %s %s%s%s%s%s%s%s%s%s",
--        set_color_1,
--        branch,
--        set_color_2,
--        file_name,
--        modified,
--        align_right,
--        filetype,
--        fileencoding,
--        fileformat,
--        percentage,
--        linecol
--    )
--end
--vim.opt.statusline = statusline()

-- Initialize configuration dictionary
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
