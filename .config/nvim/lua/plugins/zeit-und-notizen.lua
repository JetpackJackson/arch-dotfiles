return {
--    {
--        'serenevoid/kiwi.nvim',
--        dependencies = { "nvim-lua/plenary.nvim" },
--        opts = {
--            {
--                name = "zettel",
--                path = "/home/jet/docs/notes/notes-zettelkasten/"
--            },
--            {
--                name = "personal",
--                path = "/home/jet/wiki_2"
--            }
--        },
--        keys = {
--            { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
--            { "<leader>wp", ":lua require(\"kiwi\").open_wiki_index(\"zettel\")<cr>", desc = "Open index of personal wiki" },
--            { "<leader>t", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
--        },
--        lazy = true
--    },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' }
  },


-- TODO: figure out how to insert markdown lists on keypress, since that's all I really use this for anymore :(
  {
    'jakewvincent/mkdnflow.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
--    enabled = false,
    ft = "markdown",
    opts = "enabled = true",

    config = function()
        require('mkdnflow').setup({
            modules = {
                bib = false,
            },
            lazy = true,
            auto_attach = {
              enabled = true,
              filetypes = { "markdown" },
            },
            links = {
                conceal = true,
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
 
$%! TEX root = {{ filename }}$
 
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
    lazy = true,
    event = { "BufRead agenda.md" },
    opts = "enabled = true",
  },

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
