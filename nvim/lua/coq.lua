return {
    {
      "ms-jpq/coq_nvim",
      branch = "coq",
      init = function() vim.g.coq_settings = { auto_start = true } end,
      dependencies = {
          { "ms-jpq/coq.artifacts", branch = "artifacts" },
          { "neovim/nvim-lspconfig" },
      },
      config = function() require("config.ms_jpq_coq") end,
      lazy = false,
    },
}
