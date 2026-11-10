return {
  "cRhettiarachchi/nvim-c-bookmarks",
  lazy = false,
  opts = {
    ai = {
      provider = "codex",
    },
  },
  keys = {
    { "<leader>mz", function() require("c-bookmarks").toggle() end, mode = { "n", "v" }, desc = "Bookmark: toggle" },
    {
      "<leader>ma",
      function() require("c-bookmarks").add_named() end,
      mode = { "n", "v" },
      desc = "Bookmark: add named",
    },
    { "<leader>md", function() require("c-bookmarks").remove_at_cursor() end, desc = "Bookmark: remove" },
    {
      "<leader>me",
      function() require("c-bookmarks").note_edit() end,
      mode = { "n", "v" },
      desc = "Bookmark: edit note",
    },
    { "<leader>mv", function() require("c-bookmarks").note_view() end, desc = "Bookmark: view note" },
    {
      "<leader>mx",
      function() require("c-bookmarks").explain() end,
      mode = { "n", "v" },
      desc = "Bookmark: explain with AI",
    },
    { "<leader>mo", function() require("c-bookmarks").explain_model() end, desc = "Bookmark: pick AI model" },
    { "<leader>mP", function() require("c-bookmarks").explain_provider() end, desc = "Bookmark: pick AI provider" },
    { "<leader>mq", function() require("c-bookmarks").ask() end, mode = { "n", "v" }, desc = "Bookmark: ask AI" },
    {
      "<leader>ms",
      function() require("c-bookmarks").ask_selection() end,
      mode = { "n", "v" },
      desc = "Bookmark: explain selection",
    },
    { "<leader>mb", function() require("c-bookmarks").ask_bookmark() end, desc = "Bookmark: keep last answer" },
    { "<leader>mp", function() require("c-bookmarks").panel_toggle() end, desc = "Bookmark: panel" },
    { "<leader>mg", function() require("c-bookmarks").group_pick() end, desc = "Bookmark: pick group" },
    { "<leader>mn", function() require("c-bookmarks").group_new() end, desc = "Bookmark: new group" },
    { "<leader>m]", function() require("c-bookmarks").group_next() end, desc = "Bookmark: next group" },
    { "<leader>m[", function() require("c-bookmarks").group_prev() end, desc = "Bookmark: prev group" },
  },
}
