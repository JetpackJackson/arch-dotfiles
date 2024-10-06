return {
  {
    "shortcuts/no-neck-pain.nvim",
      config = function()
        require("no-neck-pain").setup({
            autocmds = {
                enableOnVimEnter = true,
            },
            buffers = {
                left = {
                    enabled = true,
                },
                right = {
                    enabled = true,
                },
            },
        })
      end
  },

}
