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

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Todo /^> TODO:/ ]],
})

--TODO: figure out how to combine file types

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.tex" },
  command = [[ syntax match Todo /^> TODO:/ ]],
})

--vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
--  pattern = { "*.md" },
--  command = [[ syntax match Red /mylab.*\</ ]],
--})

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Red /mylab.*</he=e-2 ]],
})
vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Red /LQ.*</he=e-2 ]],
})
vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Red /MATLAB.*</he=e-2 ]],
})
vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Blue /CAP.*</he=e-2 ]],
})
vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Purple /COM.*</he=e-2 ]],
})
vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Orange /COP.*</he=e-2 ]],
})



--vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
--  pattern = { "*.md" },
--  command = [[ syntax match Todo /^> TODO.*$/ ]],
--})
