return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      commentStyle = { italic = true },
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      terminalColors = false, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {
          Comment = { fg = colors.palette.sumiInk6, italic = true },
          String = { fg = colors.palette.autumnGreen },
          Identifier = { fg = colors.palette.springGreen },
          Variable = { fg = colors.palette.springGreen },
          htmlTag = { fg = colors.palette.waveRed },
          htmlTagName = { fg = colors.palette.waveRed },
          -- Telescope and UI elements
          TelescopeBorder = { fg = colors.palette.katanaGray },
          TelescopeMatching = { fg = colors.palette.katanaGray },
          TelescopePromptPrefix = { fg = colors.palette.katanaGray },
          TelescopeNormal = { fg = colors.palette.katanaGray },
        }
      end,
      theme = "dragon",
      background = { -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus",
      },
    },

    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd "colorscheme kanagawa-wave"
    end,
  },
  { "folke/which-key.nvim" },
}
