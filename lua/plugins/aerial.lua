return {
  "stevearc/aerial.nvim",
  -- master now requires nvim 0.12+; pin to the compat branch matching
  -- the installed 0.11.x until nvim is upgraded.
  branch = "nvim-0.11",
  opts = {},
  -- Aerial works off treesitter/LSP/markdown, all optional; listing
  -- nvim-treesitter here just keeps load order sane if it isn't loaded yet.
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>oo", "<cmd>AerialToggle<cr>", desc = "Aerial: Toggle outline" },
  },
}
