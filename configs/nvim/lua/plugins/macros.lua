return {
    {
    "tani/dmacro.nvim",
    config = function()
        require('dmacro').setup({
            dmacro_key = '<C-t>' --  you need to set the dmacro_key
        })
    end,
    },
}
