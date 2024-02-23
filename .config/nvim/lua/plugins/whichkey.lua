return {
      {
        "folke/which-key.nvim",
        event = "VeryLazy",
        --lazy = true,
        --keys = { "<C-k>", { "<C-x>", mode = "n" } },

        opts = {
          plugins = { spelling = true },
          defaults = {
            mode = { "n", "v" },
    --        ["g"] = { name = "+goto" },
    --        ["gz"] = { name = "+surround" },
    --        ["]"] = { name = "+next" },
    --        ["["] = { name = "+prev" },
    --        ["<leader><tab>"] = { name = "+tabs" },
            ["<leader>b"] = { name = "+buffer" },
            ["<leader>o"] = { name = "+compile" },
    --        ["<leader>f"] = { name = "+file/find" },
    --        ["<leader>g"] = { name = "+git" },
    --        ["<leader>gh"] = { name = "+hunks" },
            ["<leader>z"] = { name = "+zettelkasten" },
            ["<leader>s"] = { name = "+message search" },
    --        ["<leader>u"] = { name = "+ui" },
            ["<leader>v"] = { name = "+windows" },
            ["<leader>x"] = { name = "+diagnostics/quickfix" },
          },
        },
        config = function(_, opts)
          local wk = require("which-key")
          wk.setup(opts)
          wk.register(opts.defaults)
        end,
      },


}
