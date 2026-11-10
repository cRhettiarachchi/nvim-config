return {
  "LintaoAmons/bookmarks.nvim",
  -- pin the plugin at specific version for stability
  -- backup your bookmark sqlite db when there are breaking changes (major version change)
  tag = "3.2.0",
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope.nvim" }, -- currently has only telescopes supported, but PRs for other pickers are welcome
    { "stevearc/dressing.nvim" }, -- optional: better UI
    { "GeorgesAlkhouri/nvim-aider" }, -- optional: for Aider integration
  },
  init = function()
    -- sqlite.lua defaults to a Homebrew sqlite keg that isn't installed here.
    -- Point it at the system SQLite instead (must be set before the plugin loads).
    if vim.fn.has("mac") == 1 then
      vim.g.sqlite_clib_path = "/usr/lib/libsqlite3.dylib"
    end
  end,
  config = function()
    local opts = {} -- check the "./lua/bookmarks/default-config.lua" file for all the options
    require("bookmarks").setup(opts) -- you must call setup to init sqlite db
  end,
}
