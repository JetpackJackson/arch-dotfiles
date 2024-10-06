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
