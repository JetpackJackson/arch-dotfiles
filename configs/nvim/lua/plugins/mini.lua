return {
    {
        "echasnovski/mini.files", version = false,
        config = function()
            require('mini.files').setup({ mappings = { go_in = '<Right>', go_out = '<Left>', synchronize = 'ZZ', } })
            vim.keymap.set({ 'n', 'x', 'o' }, 'k', '<Down>')
            vim.keymap.set({ 'n', 'x', 'o' }, 'l', '<Up>')
        end
    },
}
