return {
    {
      "JetpackJackson/farin-colors",
      dependencies = { "rktjmp/lush.nvim", "rktjmp/shipwright.nvim" },
      lazy = true,
      event = { "BufRead farin*.lua", "BufRead testtrack*.lua" },
    },
    { "sainnhe/sonokai" },
--  {
--    "m4xshen/hardtime.nvim",
--    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
--    opts = {
--        disabled_keys = {
--            ["<Up>"] = {},
--            ["<Down>"] = {},
--            ["<Right>"] = {},
--            ["<Left>"] = {},
--        },}
--  },
--   {
--     'VonHeikemen/fine-cmdline.nvim',
--     dependencies = { 'MunifTanjim/nui.nvim' },
--   require('fine-cmdline.nvim').setup({
--       hooks = {
--       after_mount = function(input)
--         -- make escape go to normal mode
--         vim.keymap.set('i', '<Esc>', '<cmd>stopinsert<cr>', {buffer = input.bufnr})
--       end
--       }
--     })
--  },
--  {
--    'hachy/cmdpalette.nvim',
--    config = function ()
--      require('cmdpalette').setup({
--          win = {
--            width = 0.5,
--          },
--      })
--    end,
--  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
--    enabled = false,
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
  },

--  {
--    "folke/which-key.nvim",
--    event = "VeryLazy",
--    --lazy = true,
--    --keys = { "<C-k>", { "<C-x>", mode = "n" } },
--
--    opts = {
--      plugins = { spelling = true },
--      defaults = {
--        mode = { "n", "v" },
----        ["g"] = { name = "+goto" },
----        ["gz"] = { name = "+surround" },
----        ["]"] = { name = "+next" },
----        ["["] = { name = "+prev" },
----        ["<leader><tab>"] = { name = "+tabs" },
--        ["<leader>b"] = { name = "+buffer" },
--        ["<leader>o"] = { name = "+compile" },
----        ["<leader>f"] = { name = "+file/find" },
----        ["<leader>g"] = { name = "+git" },
----        ["<leader>gh"] = { name = "+hunks" },
--        ["<leader>z"] = { name = "+zettelkasten" },
--        ["<leader>s"] = { name = "+message search" },
----        ["<leader>u"] = { name = "+ui" },
--        ["<leader>v"] = { name = "+windows" },
--        ["<leader>x"] = { name = "+diagnostics/quickfix" },
--      },
--    },
--    config = function(_, opts)
--      local wk = require("which-key")
--      wk.setup(opts)
--      wk.register(opts.defaults)
--    end,
--  },

  {
    "shortcuts/no-neck-pain.nvim",
      config = function()
        require("no-neck-pain").setup({
            autocmds = {
                enableOnVimEnter = true,
            },
            buffers = {
                left = {
                    enabled = true,
                },
                right = {
                },
            },
        })
      end
  },

--   { "nvim-treesitter/nvim-treesitter" },

}
