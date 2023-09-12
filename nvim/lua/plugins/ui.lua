return {
  --{
  --  'goolord/alpha-nvim',
  --  config = function ()
  --      require'alpha'.setup(require'alpha.themes.dashboard'.config)
  --  end
  --},

  {
    'mhinz/vim-startify',
--    opts = function()
--      return = {
--      let s:header_cmd = 
--        \ 'fortune | cowsay deutsch -W 80 -f $(cowsay -l | sed "/[A-Z].*$/d" | shuf -n 1)'
--      let g:startify_custom_header =
--        \ startify#center(split(system(s:header_cmd), '\n'))
--      }
--    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    --opts = function(_, opts)
      --table.insert(opts.sections.lualine_x, "😄")
    --end,
  },

--  -- or you can return new options to override all the defaults
--  {
--    "nvim-lualine/lualine.nvim",
--    event = "VeryLazy",
--    opts = function()
--      return {
--        --[[add your custom lualine config here]]
--      }
--    end,
--  },
  { 'echasnovski/mini.nvim', version = false },

  { "akinsho/bufferline.nvim" },
  { "folke/flash.nvim" },
  { "folke/noice.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "rcarriga/nvim-notify" },
  { "folke/lazy.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "echasnovski/mini.pairs" },
  { "echasnovski/mini.starter" },
}

