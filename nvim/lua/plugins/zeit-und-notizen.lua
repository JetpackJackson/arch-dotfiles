return {
--    { 'lervag/vimtex' },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' }

  },
  {  'jakewvincent/mkdnflow.nvim',
     config = function()
        require('mkdnflow').setup({
            links = {
                style = 'markdown',
--                name_is_source = 'true',
            }
        })
     end
  },

  {
    "NFrid/due.nvim",
    config = function()
      require('due_nvim').setup {}
    end
  },
--  { "edluffy/hologram.nvim" },
--  { "renerocksai/calendar-vim" },

-- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  },


--  {
--    "iamcco/markdown-preview.nvim",
--    ft = "markdown",
--    build = "cd app && npm install",
--    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
--  },

  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "fzf",
        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },
          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })
    end
  },


--  {
--    'renerocksai/telekasten.nvim',
--    dependencies = {'nvim-telescope/telescope.nvim'}
--  },
--  {
--    'nvim-telescope/telescope.nvim',
--    dependencies = {'nvim-lua/plenary.nvim'}
--  },
}

--  {
--    'nvim-telescope/telescope-media-files.nvim',
--    dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' }
--  },
