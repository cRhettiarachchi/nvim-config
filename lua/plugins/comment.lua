return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("Comment").setup {
      -- LHS of toggle mappings in NORMAL mode
      toggler = {
        line = "<C-c>", -- Line-comment toggle
        block = "gbc", -- Block-comment toggle
      },
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        line = "<C-c>", -- Line-comment
        block = "<C-b>", -- Block-comment
      },
    }
  end,
}
