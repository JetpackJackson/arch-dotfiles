vim.opt.termguicolors = true
require("catppuccin").setup({
    flavour = "macchiato", -- latte(light), frappe(dark low contrast), macchiato(dark medium contrast), mocha(dark high contrast)
    background = {
        light = "latte",
    },
})
vim.cmd.colorscheme "melange"
vim.opt.background = "dark"
vim.opt.colorcolumn = "72"
