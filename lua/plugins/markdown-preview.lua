return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function() vim.g.mkdp_filetypes = { "markdown" } end,
  ft = { "markdown" },
  keys = {
    { "<leader>op", "<cmd>MarkdownPreview<cr>", desc = "Open Markdown Preview", ft = "markdown" },
    { "<leader>os", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Markdown Preview", ft = "markdown" },
  },
}
