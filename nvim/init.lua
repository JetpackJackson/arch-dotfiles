local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

vim.g.mapleader = ' '
--require("lazy").setup({{ "sainnhe/sonokai" }})
--require("lazy").setup("plugins",{})
require("lazy").setup("plugins",{{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        require'nvim-treesitter.configs'.setup {
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "bash" },
          sync_install = false,
          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
	}
      })
    end
}})

require("config.keymaps")
require("config.options")
require "user.functions"

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

-- Initialize configuration dictionary
vim.cmd([[ let g:fzf_vim = {} ]])
vim.cmd([[
        let g:fzf_vim.preview_window = 'right,50%'
        ]])

vim.cmd([[ command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0) ]])

vim.cmd([[ let g:knap_settings = {
    \ "textopdfviewerlaunch": "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
    \ "textopdfviewerrefresh": "none",
    \ "textopdfforwardjump": "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%"
\ }
]])



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

function GetWords()
  return tostring(vim.fn.wordcount().words)
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "bash" },
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}

--vim.cmd([[
--    let s:header_cmd = 'fortune deutsch | cowsay -W 80'
--    "let s:header_cmd = 'cat ~/zettel-.txt | cowsay -n'
--    let g:startify_custom_header = startify#pad(split(system(s:header_cmd), '\n'))
--    let g:startify_bookmarks = [ {'a': '$XDG_DOCUMENTS_DIR/notes/notes-zettelkasten/agenda.md'}, {'c': '~/.config/nvim/init.lua'}, {'n': '~/docs/notes/notes-zettelkasten/'} ]
--    let s:bookmarks2 = ['~/docs/notes/notes-zettelkasten/', '~/docs/notes/school/EEL3111C/lectures/']
--    let g:startify_lists = [
--      \ { 'type': 'dir',       'header': ['   MRU '.getcwd()] },
--      \ { 'type': 'files',     'header': ['   MRU' ]           },
--      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
--      \ ]
--    ]])
----#center is centered, #pad is padded
