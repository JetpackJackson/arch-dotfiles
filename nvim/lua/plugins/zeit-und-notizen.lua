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
--               style = 'wiki',
--               name_is_source = 'true',

          transform_explicit = function(text)
              text = text:gsub(" ", "-")
              text = text:lower()
              text = os.date('%Y%m%d-%H%M%S')
              return(text)
              end
          },
          new_file_template = {
              use_template = true,
              template = [[
                  # {{ title }}
                  Date: {{ date }}
                  Filename: {{ filename }}
                  ]],
              placeholders = {
                  before = {
                      date = function()
                          return os.date("%A, %B %d, %Y") -- Wednesday, March 1, 2023
                      end
                  },
                  after = {
                      filename = function()
                          return vim.api.nvim_buf_get_name(0)
                      end
                  }
              }
          },
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

  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  },

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
}
