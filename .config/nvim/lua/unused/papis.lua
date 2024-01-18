return {
    {
      "jghauser/papis.nvim",
      dependencies = {
        "kkharji/sqlite.lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("papis").setup({
          -- Your configuration goes here
          -- These are configuration options of the `papis` program relevant to papis.nvim.
          -- Papis.nvim can get them automatically from papis, but this is very slow. It is
          -- recommended to copy the relevant settings from your papis configuration file.
          papis_python = {
            dir = "/home/jet/docs/notes/zitate",
            info_name = "info.yaml", -- (when setting papis options `-` is replaced with `_`
                                     -- in the keys names)
            notes_name = [[notes.norg]],
          },
          -- Enable the default keymaps
          enable_keymaps = true,
      })
    end,
    }
}
