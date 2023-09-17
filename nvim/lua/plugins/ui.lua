return {
--  { "adoyle-h/lsp-toggle.nvim" },

  { "nvim-treesitter/nvim-treesitter" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "shortcuts/no-neck-pain.nvim" },
  { "SmiteshP/nvim-navic" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  {
    'mhinz/vim-startify',
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    --opts = function(_, opts)
      --table.insert(opts.sections.lualine_x, "😄")
    --end,
  },
  --{ "folke/flash.nvim" },
--  {
--    "akinsho/bufferline.nvim",
--    event = "VeryLazy",
--    keys = {
--      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
--      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
--    },
--    opts = {
--      options = {
--        -- stylua: ignore
--        close_command = function(n) require("mini.bufremove").delete(n, false) end,
--        -- stylua: ignore
--        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
--        diagnostics = "nvim_lsp",
--        always_show_bufferline = false,
--        diagnostics_indicator = function(_, _, diag)
--          --local icons = require("lazyvim.config").icons.diagnostics
--          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
--            .. (diag.warning and icons.Warn .. diag.warning or "")
--          return vim.trim(ret)
--        end,
--        offsets = {
--          {
--            filetype = "neo-tree",
--            text = "Neo-tree",
--            highlight = "Directory",
--            text_align = "left",
--          },
--        },
--      },
--    },
--  },
--  {
--    "echasnovski/mini.bufremove",
--    -- stylua: ignore
--    keys = {
--      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
--      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
--    },
--  },

  {
    "folke/noice.nvim",
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


  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  { "folke/lazy.nvim" },
--  {
--    "echasnovski/mini.indentscope",
--    version = false, -- wait till new 0.7.0 release to put it back on semver
--    event = { "BufReadPre", "BufNewFile" },
--    opts = {
--      -- symbol = "▏",
--      symbol = "│",
--      options = { try_as_border = true },
--    },
--    init = function()
--      vim.api.nvim_create_autocmd("FileType", {
--        pattern = {
--          "help",
--          "alpha",
--          "dashboard",
--          "neo-tree",
--          "Trouble",
--          "lazy",
--          "mason",
--          "notify",
--          "toggleterm",
--          "lazyterm",
--        },
--        callback = function()
--          vim.b.miniindentscope_disable = true
--        end,
--      })
--    end,
--  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  }


}

