return {
--  { "frabjous/knap" },
--    { "yinflying/matlab-screen" },
--  { 'daeyun/vim-matlab' },
--    { 'lervag/vimtex' },
--  {
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' }
  },

  {
    'jakewvincent/mkdnflow.nvim',
    ft = "markdown",
    opts = "enabled = true",

    config = function()
        require('mkdnflow').setup({
          lazy = true,
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
          links = {
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
---
tags:
- 
---

# {{ title }}
Date: {{ date }}
Filename: {{ filename }}
]],
              placeholders = {
                  before = {
                      date = function()
                          return os.date("%A, %B %d, %Y")-- Wednesday, March 1, 2023
--                          return os.date('%Y%m%d-%H%M%S')
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
--    ft = "markdown",
    lazy = true,
    event = { "BufRead agenda.md" },
    opts = "enabled = true",
  },
--  {
--      "iamcco/markdown-preview.nvim",
--      init = function()
--          vim.g.mkdp_filetypes = { "markdown" }
--      end,
--      ft = { "markdown" },
--      cmd = {
--          "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle"
--      },
--      event = "BufRead",
--      build = function()
--          vim.fn["mkdp#util#install"]()
--      end,
--  },

  {
    "mickael-menu/zk-nvim",
    ft = "markdown",
    opts = "enabled = true",
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
