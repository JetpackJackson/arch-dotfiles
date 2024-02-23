return {
    {
      "JetpackJackson/farin-colors",
      dependencies = { "rktjmp/lush.nvim", "rktjmp/shipwright.nvim" },
      lazy = true,
      event = { "BufRead farin*.lua", "BufRead testtrack*.lua" },
    },
    { "sainnhe/sonokai" },
--    { 'matsuuu/pinkmare' },
--    { 'Yazeed1s/oh-lucy.nvim' },
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
--              width = 0.5,
--          },
--          buf = {
--              filetype = "cmdpalette",
--          },
--      })
--    end,
--  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    --enabled = false,
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


-- noneckpain and noice refresh intro screen

}
