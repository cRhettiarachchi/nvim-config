return {
  'neanias/everforest-nvim',
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('everforest').setup {
      transparent_background_level = 1,
      background = 'hard',
      dim_inactive_windows = true,
      diagnostic_text_highlight = true,
      options = {
        theme = 'everforest', -- Can also be "auto" to detect automatically.
      },
    }
  end,
}
