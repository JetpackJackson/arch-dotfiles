--vim.api.nvim_create_autocmd( { "BufWritePost" }, {
--  pattern = { "*.md" },
--  command = [[ !zetcom % ]],
--})

--vim.cmd([[hi texCmd guifg=#ad3da4 guibg=NONE gui=NONE ctermfg=127 ctermbg=NONE cterm=NONE
--hi! link texMathEnvArgName texEnvArgName
--hi! link texMathZone LocalIdent
--hi! link texMathZoneEnv texMathZone
--hi! link texMathZoneEnvStarred texMathZone
--hi! link texMathZoneX texMathZone
--hi! link texMathZoneXX texMathZone
--hi! link texMathZoneEnsured texMathZone
--hi! link QuickFixLine Normal
--hi! link qfLineNr Normal
--hi! link EndOfBuffer LineNr
--hi! link Conceal LocalIdent
--]])

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Comment /^\-\-.*\-\-/ ]],
})

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Comment /^- \[X\].*$/ ]],
})

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Comment /^    - \[X\].*$/ ]],
})

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Comment /^        - \[X\].*$/ ]],
})

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Directory /^- \[-\].*$/ ]],
})

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Directory /^    - \[-\].*$/ ]],
})

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Directory /^        - \[-\].*$/ ]],
})

