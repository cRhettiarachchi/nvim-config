return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    -- Default of 20 was silently dropping context for TS/TSX nodes (long
    -- function signatures, generics, etc.) that span more lines than that.
    multiline_threshold = 200,
  },
}
