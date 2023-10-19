vim.g.mapleader = ' '
--vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
--  pattern = { "*.py" },
--  command = [[ syntax match Error /┊/ ]],
--  --command = [[ syntax match Comment /^[[:space:]][-*] \[X\].*$/ ]],
--})

--vim.api.nvim_create_autocmd( { "BufWritePost" }, {
--  pattern = "*.md",
--  command = "silent !pandoc % -o %:r.pdf && !zathura %:r.pdf",
--})
--vim.keymap.set("v", "<F4>", ":s/\S\+//gn")
vim.keymap.set("n", "<F6>", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>")
vim.keymap.set("n", "<F5>", ":retab")
vim.keymap.set("n", "gp", "[v]")

vim.api.nvim_create_autocmd( { "BufWrite", "BufRead" }, {
  pattern = { "*.md" },
  command = [[ syntax match Comment /^- \[X\].*$/ ]],
  --command = [[ syntax match Comment /^[[:space:]][-*] \[X\].*$/ ]],
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

vim.api.nvim_set_keymap('n', '<leader>oo', ':!zetpdf %<CR>', { noremap = true, silent = true })

local zk = require("zk")
local commands = require("zk.commands")

commands.add("ZkOrphans", function(options)
  options = vim.tbl_extend("force", { orphan = true }, options or {})
  zk.edit(options, { title = "Zk Orphans" })
end)
local opts = { noremap = true, silent = false }
vim.api.nvim_set_keymap("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><Tab>", "<Cmd>MkdnTab<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><BS>", "<Cmd>MkdnSTab<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>x", "<Cmd>MkdnToggleToDo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<Cmd>MkdnTableFormat<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>s", ":'<,'>sort /[^<]*</<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for title.
vim.api.nvim_set_keymap("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
vim.api.nvim_set_keymap("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
-- Open notes linking to the current buffer.
vim.api.nvim_set_keymap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
-- Open notes linked by the current buffer.
vim.api.nvim_set_keymap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
-- Preview a linked note.
vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- Open the code actions for a visual selection.
vim.api.nvim_set_keymap("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>l', ':Lazy<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>t', ':TodoLocList<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NoNeckPain<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>h', ':Startify<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':Buffers<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>lt', ':NoNeckPain<CR>|<C-w><Left>|:terminal<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ob', ':VimtexCompile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':!kitty &<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bw', ':bw!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><C-f>', ':%s@', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>vv', '<C-w>v<CR><C-w><Right>', { noremap = true })

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)
-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>zi', ':ZkInsertLinkAtSelection<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>zb', ':ZkBacklinks<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>rr', ':!sh -xc fzf-notes<CR>', { noremap = true, silent = true })
vim.cmd([[tnoremap <Esc> <C-\><C-n>]])
