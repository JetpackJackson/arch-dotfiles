return {
  {
    "shortcuts/no-neck-pain.nvim",
    --enabled = false,
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
                },
            },
        })
      end
  },

}
