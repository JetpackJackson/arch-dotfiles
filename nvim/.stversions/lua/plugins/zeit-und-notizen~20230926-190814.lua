return {
--    { 'lervag/vimtex' },
--  {
--    'junegunn/fzf.vim',
--    dependencies = { 'junegunn/fzf' }
--
--  },
  {  'jakewvincent/mkdnflow.nvim',
     config = function()
        require('mkdnflow').setup({
            -- Config goes here; leave blank for defaults
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
  { "renerocksai/calendar-vim" },

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
    'renerocksai/telekasten.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'}
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim'}
  },
}

--  {
--    'nvim-telescope/telescope-media-files.nvim',
--    dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' }
--  },
