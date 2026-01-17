return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  opts = {
    enable_autocmd = false, -- Important: disable autocmd since Comment.nvim handles it
  },
  config = function(_, opts) require("ts_context_commentstring").setup(opts) end,
}
