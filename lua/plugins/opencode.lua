return {
  "NickvanDyke/opencode.nvim",
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Use tmux instead of neovim terminal
      terminal = {
        provider = "tmux",
        -- Optional: configure tmux behavior
        tmux = {
          -- Split direction: "horizontal" or "vertical"
          split_direction = "horizontal",
          -- Percentage of space for the new pane (0-100)
          split_size = 30,
          -- Or use a specific pane/window target
          -- target = "{last}", -- or specific pane like ":.1"
        },
      },
      -- Enable auto-reload when opencode makes changes
      events = {
        reload = true,
      },
    }
    vim.o.autoread = true

    -- Leader-based keymaps
    vim.keymap.set(
      { "n", "x" },
      "<leader>oa",
      function() require("opencode").ask("@this: ", { submit = true }) end,
      { desc = "OpenCode: Ask" }
    )

    vim.keymap.set(
      { "n", "x" },
      "<leader>os",
      function() require("opencode").select() end,
      { desc = "OpenCode: Select action" }
    )

    vim.keymap.set(
      { "n", "t" },
      "<leader>ot",
      function() require("opencode").toggle() end,
      { desc = "OpenCode: Toggle" }
    )

    -- Visual mode: send selection to opencode
    vim.keymap.set(
      "x",
      "<leader>oo",
      function() require("opencode").operator "@this " end,
      { desc = "OpenCode: Send selection" }
    )

    -- Operator mode for quick ranges
    vim.keymap.set(
      "n",
      "<leader>oo",
      function() return require("opencode").operator "@this " end,
      { desc = "OpenCode: Add range", expr = true }
    )

    -- Current line
    vim.keymap.set(
      "n",
      "<leader>ol",
      function() return require("opencode").operator "@this " .. "_" end,
      { desc = "OpenCode: Add current line", expr = true }
    )
  end,
}
