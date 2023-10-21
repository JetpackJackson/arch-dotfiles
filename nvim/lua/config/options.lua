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

