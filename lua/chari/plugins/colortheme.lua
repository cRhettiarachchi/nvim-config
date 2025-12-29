return {
  'sainnhe/edge',
  lazy = false, -- Load immediately, not lazy-loaded
  priority = 1000, -- Load before other plugins
  config = function()
    -- Optional: Configure edge settings before loading
    -- vim.g.edge_style = 'aura' -- Options: 'default', 'aura', 'neon'
    -- vim.g.edge_better_performance = 1

    vim.cmd.colorscheme 'edge'
  end,
}
