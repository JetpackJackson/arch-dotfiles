vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<F1>', ':Startify<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F2>', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F3>', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', ':Telekasten find_daily_notes<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', ':Lazy<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>h', ':Startify<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fd', ':Telekasten find_daily_notes<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>la', ':Lazy<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':TodoLocList<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NoNeckPain<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fi', ':Telekasten search_notes<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':Mason<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':Telekasten switch_vault<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>lt', ':NoNeckPain<CR>|<C-w><Left>|:terminal<CR>i', { noremap = true })

vim.cmd([[tnoremap <Esc> <C-\><C-n>]])


---- better up/down
--vim.api.nvim_set_keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--vim.api.nvim_set_keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--
---- Move to window using the <ctrl> hjkl keys
--vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
--vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
--vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
--vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
--
---- Resize window using <ctrl> arrow keys
--vim.api.nvim_set_keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
--vim.api.nvim_set_keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
--vim.api.nvim_set_keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
--vim.api.nvim_set_keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
--
---- Move Lines
--vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
--vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
--vim.api.nvim_set_keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
--vim.api.nvim_set_keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
--vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
--vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
--
---- buffers
--if Util.has("bufferline.nvim") then
--  vim.api.nvim_set_keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--  vim.api.nvim_set_keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--  vim.api.nvim_set_keymap("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--  vim.api.nvim_set_keymap("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--else
--  vim.api.nvim_set_keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--  vim.api.nvim_set_keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
--  vim.api.nvim_set_keymap("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--  vim.api.nvim_set_keymap("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
--end
--vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
--vim.api.nvim_set_keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
--
---- Clear search with <esc>
--vim.api.nvim_set_keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
--
---- Clear search, diff update and redraw
---- taken from runtime/lua/_editor.lua
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>ur",
--  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--  { desc = "Redraw / clear hlsearch / diff update" }
--)
--
---- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
--vim.api.nvim_set_keymap("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--vim.api.nvim_set_keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--vim.api.nvim_set_keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--vim.api.nvim_set_keymap("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--vim.api.nvim_set_keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--vim.api.nvim_set_keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--
---- Add undo break-points
--vim.api.nvim_set_keymap("i", ",", ",<c-g>u")
--vim.api.nvim_set_keymap("i", ".", ".<c-g>u")
--vim.api.nvim_set_keymap("i", ";", ";<c-g>u")
--
---- save file
--vim.api.nvim_set_keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
--
----keywordprg
--vim.api.nvim_set_keymap("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
--
---- better indenting
--vim.api.nvim_set_keymap("v", "<", "<gv")
--vim.api.nvim_set_keymap("v", ">", ">gv")
--
---- lazy
--vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
--
---- new file
--vim.api.nvim_set_keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
--
--vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
--vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
--
--if not Util.has("trouble.nvim") then
--  vim.api.nvim_set_keymap("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
--  vim.api.nvim_set_keymap("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
--end
--
---- stylua: ignore start
--
---- toggle options
--vim.api.nvim_set_keymap("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
--vim.api.nvim_set_keymap("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
--vim.api.nvim_set_keymap("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
--vim.api.nvim_set_keymap("n", "<leader>ul", function() Util.toggle_number() end, { desc = "Toggle Line Numbers" })
--vim.api.nvim_set_keymap("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
--local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
--vim.api.nvim_set_keymap("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
--if vim.lsp.inlay_hint then
--  vim.api.nvim_set_keymap("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
--end
--
---- lazygit
--vim.api.nvim_set_keymap("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
--vim.api.nvim_set_keymap("n", "<leader>gG", function() Util.float_term({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })
--
---- quit
--vim.api.nvim_set_keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
--
---- highlights under cursor
--if vim.fn.has("nvim-0.9.0") == 1 then
--  vim.api.nvim_set_keymap("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
--end
--
---- LazyVim Changelog
--vim.api.nvim_set_keymap("n", "<leader>L", Util.changelog, {desc = "LazyVim Changelog"})
--
---- floating terminal
--local lazyterm = function() Util.float_term(nil, { cwd = Util.get_root() }) end
--vim.api.nvim_set_keymap("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
--vim.api.nvim_set_keymap("n", "<leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
--vim.api.nvim_set_keymap("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
--vim.api.nvim_set_keymap("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })
--
---- Terminal Mappings
--vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
--vim.api.nvim_set_keymap("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
--vim.api.nvim_set_keymap("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
--vim.api.nvim_set_keymap("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
--vim.api.nvim_set_keymap("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
--vim.api.nvim_set_keymap("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
--vim.api.nvim_set_keymap("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
--
---- windows
--vim.api.nvim_set_keymap("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
--vim.api.nvim_set_keymap("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
--vim.api.nvim_set_keymap("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
--vim.api.nvim_set_keymap("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
--vim.api.nvim_set_keymap("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
--vim.api.nvim_set_keymap("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
--
---- tabs
--vim.api.nvim_set_keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
--vim.api.nvim_set_keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
--vim.api.nvim_set_keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
--vim.api.nvim_set_keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
--vim.api.nvim_set_keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
--vim.api.nvim_set_keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
