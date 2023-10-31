vim.o.makeprg = 'pandoc % -o %:r.pdf'
vim.cmd([[syntax match Comment "/^- \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^    - \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^        - \[X\].*$/"]])
vim.cmd([[syntax match Directory "/^- \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^    - \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^        - \[-\].*$/"]])
