return {
    {
        "echasnovski/mini.files", version = false,
        config = function()
            require('mini.files').setup({ mappings = { go_in = ';', go_out = 'j' } })
            vim.keymap.set({ 'n', 'x', 'o' }, 'k', '<Down>')
            vim.keymap.set({ 'n', 'x', 'o' }, 'l', '<Up>')
        end
    },
}
