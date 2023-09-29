return {
    { "JetpackJackson/farin-colors" },
    { "ellisonleao/gruvbox.nvim" },
--  { "AlessandroYorba/Sierra" },
--  { "EdenEast/nightfox.nvim" },
--  { "cocopon/iceberg.vim" },
--  { "katawful/kreative" },
--  { "namrabtw/rusty.nvim" },
--  { "rebelot/kanagawa.nvim" },
--  { "rktjmp/lush.nvim" },
--  { "sainnhe/everforest" },
--  { "sainnhe/everforest" },
--  {'Iron-E/nvim-highlite'},
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
        disabled_keys = {
            ["<Up>"] = {},
            ["<Down>"] = {},
            ["<Right>"] = {},
            ["<Left>"] = {},
        },}
  },

  { "nvim-treesitter/nvim-treesitter" },
--  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "shortcuts/no-neck-pain.nvim" },
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
        "startify",
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

  --{
  --  'folke/which-key.nvim',
  --  enabled = true,
  --  dependencies = { 'Wansmer/langmapper.nvim' },
  --  config = function()
  --    vim.o.timeout = true
  --    vim.o.timeoutlen = 300

  --    local lmu = require('langmapper.utils')
  --    local view = require('which-key.view')
  --    local execute = view.execute

  --  -- wrap `execute()` and translate sequence back
  --    view.execute = function(prefix_i, mode, buf)
  --    -- Translate back to English characters
  --      prefix_i = lmu.translate_keycode(prefix_i, 'default', 'ru')
  --      execute(prefix_i, mode, buf)
  --    end

  --  -- If you want to see translated operators, text objects and motions in
  --  -- which-key prompt
  --  -- local presets = require('which-key.plugins.presets')
  --  -- presets.operators = lmu.trans_dict(presets.operators)
  --  -- presets.objects = lmu.trans_dict(presets.objects)
  --  -- presets.motions = lmu.trans_dict(presets.motions)
  --  -- etc

  --    require('which-key').setup()
  --  end,
  --},

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

