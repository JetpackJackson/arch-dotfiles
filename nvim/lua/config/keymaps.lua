vim.g.mapleader = ' '
-- set shorter name for keymap function
--local kmap = vim.keymap.set
--
---- F5 processes the document once, and refreshes the view
--kmap({ 'n', 'v', },'<leader>Po', function() require("knap").process_once() end)
--
---- F6 closes the viewer application, and allows settings to be reset
--kmap({ 'n', 'v', },'<leader>Pc', function() require("knap").close_viewer() end)
--
---- F7 toggles the auto-processing on and off
--kmap({ 'n', 'v', },'<F7>', function() require("knap").toggle_autopreviewing() end)
--
---- F8 invokes a SyncTeX forward search, or similar, where appropriate
--kmap({ 'n', 'v', },'<F8>', function() require("knap").forward_jump() end)

local zk = require("zk")
local commands = require("zk.commands")

commands.add("ZkOrphans", function(options)
  options = vim.tbl_extend("force", { orphan = true }, options or {})
  zk.edit(options, { title = "Zk Orphans" })
end)
-- Add the key mappings only for Markdown files in a zk notebook.
local opts = { noremap = true, silent = false }
-- Open the link under the caret.
vim.api.nvim_set_keymap("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
--vim.api.nvim_set_keymap("n", "<BS>", "<Cmd>bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", "<Cmd>MkdnToggleToDo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>s", ":'<,'>sort /[^<]*</<CR>", { noremap = true, silent = true })
-- Create a new note after asking for its title.
-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for title.
vim.api.nvim_set_keymap("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
vim.api.nvim_set_keymap("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes linking to the current buffer.
vim.api.nvim_set_keymap("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
-- Alternative for backlinks using pure LSP and showing the source context.
--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
-- Open notes linked by the current buffer.
vim.api.nvim_set_keymap("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
-- Preview a linked note.
vim.api.nvim_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- Open the code actions for a visual selection.
vim.api.nvim_set_keymap("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)


vim.api.nvim_set_keymap('n', '<leader>l', ':Lazy<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>t', ':TodoLocList<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NoNeckPain<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':Startify<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>bb', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':Buffers<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>lt', ':NoNeckPain<CR>|<C-w><Left>|:terminal<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':terminal<CR>i', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>c', ':Calendar<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bw', ':bw!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><C-f>', ':%s@', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>v', '<C-w>v<CR><C-w><Right>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>zt', 'ZkTags<CR>', { noremap = true })

local opts = { noremap = true, silent = false }

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



--vim.keymap.set("n", "<leader>zp", "<cmd>Telekasten panel<CR>", { noremap = true })
--vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten find_daily_notes<CR>")
--vim.api.nvim_set_keymap('n', '<leader>fd', ':Telekasten find_daily_notes<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>ex', ':LspStart ltex', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>dx', ':LspStop ltex', { noremap = true })

--vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten goto_today<CR>")
--vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
--vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
--vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })

--vim.api.nvim_set_keymap('n', '<leader>zs', ':Telekasten search_notes<CR>', { noremap = true })
--vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")

--vim.api.nvim_set_keymap('n', '<leader>sv', ':Telekasten switch_vault<CR>', { noremap = true })

--vim.api.nvim_set_keymap('n', '<leader>fl', ':Telekasten follow_link<CR>', { noremap = true })

--vim.api.nvim_set_keymap('n', '<leader>rr', ':!sh -xc fzf-notes<CR>', { noremap = true, silent = true })

--vim.keymap.set("i", "---", "<cmd>Telekasten insert_link<CR>")

--vim.api.nvim_set_keymap('n', '<leader>fc', ':Circuits<CR>', { noremap = true })

--a.nvim_create_autocmd( { "BufWritePre" }, {
--  pattern = { "*.py" },
--  command = [[ !/bin/black % ]],
--})

vim.cmd([[tnoremap <Esc> <C-\><C-n>]])
