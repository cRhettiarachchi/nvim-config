return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    require("lualine").setup {
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- 1 = Relative path from project root
            symbols = {
              modified = "[+]", -- Text to show when file is modified
              readonly = "[-]", -- Text to show when file is readonly
              unnamed = "[No Name]", -- Text to show for unnamed buffers
              newfile = "[New]", -- Text to show for new files
            },
          },
        },
      },
    }
  end,
}
