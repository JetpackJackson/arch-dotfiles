vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>l', ':Lazy<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>t', ':TodoLocList<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NoNeckPain<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':Startify<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>bb', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':Buffers<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>lt', ':NoNeckPain<CR>|<C-w><Left>|:terminal<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>i', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>c', ':Calendar<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bw', ':bw!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><C-f>', ':%s@', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>v', '<C-w>v<CR><C-w><Right>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>zt', 'ZkTags<CR>', { noremap = true })

local opts = { noremap=true, silent=false }

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
