-- return {
--   "numToStr/Comment.nvim",
--   config = function()
--     local prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

--     require("Comment").setup {
--       padding = true,
--       sticky = true,
--       ignore = "^$",
--       toggler = {
--         line = "<C-c>",
--         block = "<C-b>",
--       },
--       opleader = {
--         line = "gc",
--         block = "gb",
--       },
--       extra = {
--         above = "gcO",
--         below = "gco",
--         eol = "gcA",
--       },
--       mappings = {
--         basic = true,
--         extra = true,
--         extended = false,
--       },
--       pre_hook = prehook,
--       post_hook = nil,
--     }
--   end,
--   event = "InsertEnter",
--   lazy = true,
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "JoosepAlviste/nvim-ts-context-commentstring",
--   },
-- }
return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup {
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = {
        line = "<C-c>", -- Normal mode: toggle single line comment
        block = "<C-b>", -- Normal mode: toggle block comment
      },
      opleader = {
        line = "<C-c>", -- Visual mode: toggle single line comment
        block = "<C-b>", -- Visual mode: toggle block comment
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
  event = { "BufReadPost", "BufNewFile" },
  lazy = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}
