-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--vim.keymap.set('n', 'n', 'h')
--vim.keymap.set('n', 'r', 'j')
--vim.keymap.set('n', 's', 'k')
--vim.keymap.set('n', 'k', 'l')
--vim.keymap.set('n', 'h', 'n')
--vim.keymap.set('n', 'H', 'N')
--vim.keymap.set('n', 'ß', 'r')
-- This file is automatically loaded by lazyvim.config.init

vim.g.mapleader = ' '
--vim.api.nvim_set_keymap('n', '<F1>', ':Startify<CR>', { noremap = false })
--vim.api.nvim_set_keymap('n', '<F2>', ':Telescope buffers<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<F3>', ':Telescope find_files<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>gn', ':Gitsigns next_hunk<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>gp', ':Gitsigns prev_hunk<CR>', { noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true })


-- better up/down
vim.api.nvim_set_keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.api.nvim_set_keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.api.nvim_set_keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.api.nvim_set_keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.api.nvim_set_keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.api.nvim_set_keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.api.nvim_set_keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.api.nvim_set_keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
if Util.has("bufferline.nvim") then
  vim.api.nvim_set_keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  vim.api.nvim_set_keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  vim.api.nvim_set_keymap("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  vim.api.nvim_set_keymap("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  vim.api.nvim_set_keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.api.nvim_set_keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  vim.api.nvim_set_keymap("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.api.nvim_set_keymap("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.api.nvim_set_keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
vim.api.nvim_set_keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.api.nvim_set_keymap(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.api.nvim_set_keymap("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.api.nvim_set_keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.api.nvim_set_keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.api.nvim_set_keymap("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.api.nvim_set_keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.api.nvim_set_keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() Util.toggle_number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end

-- lazygit
map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Util.float_term({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- LazyVim Changelog
map("n", "<leader>L", Util.changelog, {desc = "LazyVim Changelog"})

-- floating terminal
local lazyterm = function() Util.float_term(nil, { cwd = Util.get_root() }) end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
