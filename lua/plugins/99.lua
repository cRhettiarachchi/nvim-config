return {
  "ThePrimeagen/99",
  config = function()
    local _99 = require "99"

    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    _99.setup {
      provider = _99.Providers.ClaudeCodeProvider,
      model = "claude-sonnet-4-6",

      -- keep tmp_dir INSIDE cwd or Claude Code hits permission errors
      tmp_dir = "./tmp",

      logger = {
        level = _99.DEBUG,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
      },

      md_files = { "AGENT.md" },
    }

    -- visual: replace selection with result (v mode only, by design)
    vim.keymap.set("v", "<leader>9v", function() _99.visual() end)

    -- search: the one Prime says to actually use
    vim.keymap.set("n", "<leader>9s", function() _99.search() end)

    -- kill in-flight requests
    vim.keymap.set("n", "<leader>9x", function() _99.stop_all_requests() end)

    -- telescope model + provider pickers (switch on the fly)
    vim.keymap.set("n", "<leader>9m", function() require("99.extensions.telescope").select_model() end)
    vim.keymap.set("n", "<leader>9p", function() require("99.extensions.telescope").select_provider() end)
  end,
}
