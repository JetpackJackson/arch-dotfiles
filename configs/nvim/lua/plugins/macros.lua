return {
--    {
--    "tani/dmacro.nvim",
--    config = function()
--        require('dmacro').setup({
--            dmacro_key = '<C-t>' --  you need to set the dmacro_key
--        })
--    end,
--    },
--    {
--        "tani/dmacro.nvim",
--        event = { "BufReadPost", "VeryLazy" },
--        config = { dmacro_key = "<C-t>", },
--    }
    {
    'tani/dmacro.nvim',
    priority = 10,
    lazy = false,
    config = function()
      require('dmacro').setup({
        dmacro_key = '<C-y>'
      })
    end
    },
}
