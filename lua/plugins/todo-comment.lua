return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    {
      "<leader>ft",
      "<cmd>TodoTelescope<CR>",
      desc = "Find TODO / NOTE comments",
    },
  },
}
