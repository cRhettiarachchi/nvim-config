return {
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>bm", function() require("buffer_manager.ui").toggle_quick_menu() end, desc = "Buffer manager" },
  },
  config = function()
    require("buffer_manager").setup {
      select_menu_item_commands = {
        edit = { key = "<CR>", command = "edit" },
        v = { key = "<C-v>", command = "vsplit" },
        h = { key = "<C-h>", command = "split" },
      },
      focus_alternate_buffer = false,
      short_file_names = true,
      short_term_names = true,
    }
  end,
}
