return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "JetpackJackson/farin-colors" },
  { "sainnhe/everforest" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  }
}
