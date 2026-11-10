return {
  "folke/trouble.nvim",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
    {
      "<leader>cr",
      "<cmd>Trouble lsp_references toggle focus=false win.position=right<cr>",
      desc = "LSP references (Trouble)",
    },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false win.position=right<cr>", desc = "Symbols (Trouble)" },
  },
}
