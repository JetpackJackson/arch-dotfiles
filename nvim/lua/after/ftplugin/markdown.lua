vim.o.makeprg = 'pandoc % -o %:r.pdf'
vim.cmd([[syntax match Comment "/^- \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^    - \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^        - \[X\].*$/"]])
vim.cmd([[syntax match Directory "/^- \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^    - \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^        - \[-\].*$/"]])
vim.cmd([[syntax match Comment "/^- \[M\].*$/"]])
--MoreMsg Todo
vim.api.nvim_create_autocmd( { "BufWrite", "BufRead", "BufReadPre" }, {
  pattern = { "*.md" },
  command = [[ syntax match Comment /^- \[M\].*$/ ]],
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

