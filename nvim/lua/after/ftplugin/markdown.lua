--vim.cmd([[set conceallevel=2
--
--highlight default link customConceals Normal
--syntax match Comment '\[ \]' conceal cchar=4
--syntax match Comment "\[x\]" conceal cchar=5
--syntax match Comment "\\_" conceal cchar=_
--]])
--
--vim.cmd([[syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" keepend contained conceal contains=markdownUrl]])
--
--vim.cmd([[syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal]])
--
--vim.cmd([[syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends]])

--vim.cmd([[syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends]])

vim.o.makeprg = 'pandoc % -o %:r.pdf'
vim.cmd([[syntax match Comment "/^- \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^    - \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^        - \[X\].*$/"]])
vim.cmd([[syntax match Directory "/^- \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^    - \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^        - \[-\].*$/"]])
