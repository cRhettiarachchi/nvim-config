return {
  "ThePrimeagen/99",
  config = function()
    local _99 = require "99"

    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    -- The claude CLI has no way to list its models (anthropics/claude-code#12612),
    -- so 99 hardcodes ClaudeCodeProvider's list for the <leader>9m picker. Patch
    -- it here so the picker offers the current Claude 5 lineup alongside the
    -- older models it still ships with.
    _99.Providers.ClaudeCodeProvider.fetch_models = function(callback)
      callback({
        "claude-opus-5.5",
        "claude-sonnet-5",
        "claude-fable-5",
        "claude-haiku-4-5-20251001",
        "claude-opus-4-6",
        "claude-sonnet-4-5",
        "claude-haiku-4-5",
        "claude-opus-4-5",
        "claude-opus-4-1",
        "claude-sonnet-4-0",
        "claude-opus-4-0",
        "claude-3-7-sonnet-latest",
      }, nil)
    end

    _99.setup {
      provider = _99.Providers.ClaudeCodeProvider,
      model = "claude-opus-5",

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

    -- explain unstaged changes: prompt text for <leader>9e, see below
    local EXPLAIN_CHANGES_PROMPT = [[
Explain the current unstaged changes, excluding Markdown files, Vite configuration, and test files. Ignore imports entirely, including import-only changes.

Organize the explanation by logical change. For each changed method, function, or variable:

Briefly explain what changed and how it affects behavior.

Directly beneath the explanation, show the changed code and all directly related usages, including unchanged usages.

Mark the first usage with ^- and subsequent usages under the same parent with --. These markers represent sibling usages at the same hierarchy level. Restart with ^- for each new parent.

Add only the minimum explanation needed for each important usage.

Include file paths and line numbers.

Keep related code together. Avoid unrelated code and repetitive explanations. If the reason for a change is uncertain, label it as an inference.

the files that needs to be included are
]]

    -- search: the one Prime says to actually use
    vim.keymap.set("n", "<leader>9s", function() _99.search() end)

    -- open the search prompt pre-filled with EXPLAIN_CHANGES_PROMPT so details
    -- can be added before submitting with :w. search() focuses the 99 prompt
    -- window synchronously, so the current buffer is the one to fill.
    vim.keymap.set("n", "<leader>9e", function()
      _99.search()
      local buf = vim.api.nvim_get_current_buf()
      -- 99 sets ft "99" on the prompt buffer; its completion hook later renames it "99prompt"
      local ft = vim.bo[buf].filetype
      if ft ~= "99" and ft ~= "99prompt" then return end
      local lines = vim.split(EXPLAIN_CHANGES_PROMPT, "\n", { plain = true })
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.api.nvim_win_set_cursor(0, { #lines, 0 })
    end)

    -- kill in-flight requests
    vim.keymap.set("n", "<leader>9x", function() _99.stop_all_requests() end)

    -- telescope model + provider pickers (switch on the fly)
    vim.keymap.set("n", "<leader>9m", function() require("99.extensions.telescope").select_model() end)
    vim.keymap.set("n", "<leader>9p", function() require("99.extensions.telescope").select_provider() end)
  end,
}
