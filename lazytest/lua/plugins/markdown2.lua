return {
{"iamcco/markdown-preview.nvim",
  ft = "markdown",
  -- build = "cd app && yarn install", -- after removing Joplin one day
  build = "cd app && npm install",
  init = function() vim.g.mkdp_filetypes = { "markdown" } end,
},
}
