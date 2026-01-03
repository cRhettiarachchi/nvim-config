return {
  "sindrets/diffview.nvim",

  init = function()
    vim.keymap.set({ "n", "v" }, "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff View open" })
    vim.keymap.set({ "n", "v" }, "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Diff View close" })
    vim.keymap.set({ "n", "v" }, "<leader>gf", "<cmd>DiffviewFileHistory<cr>", { desc = "Diff View file" })
  end,
}
