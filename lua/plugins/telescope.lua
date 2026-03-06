return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    {
      "isak102/telescope-git-file-history.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "tpope/vim-fugitive",
      },
    },
  },

  config = function()
    local telescope = require "telescope"
    telescope.setup {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "%.lock",
          "package%-lock%.json",
          "yarn%.lock",
          "pnpm%-lock%.yaml",
          "bun%.lockb",
          "vendor/",
          "%.min%.js",
          "%.min%.css",
          "dist/",
          "build/",
          "target/",
          "%.class",
          "%.pyc",
          "__pycache__/",
          "%.o",
          "%.a",
          "%.so",
          "%.dylib",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        -- LSP pickers should NOT ignore node_modules (for library definitions)
        lsp_definitions = {
          file_ignore_patterns = {},
        },
        lsp_references = {
          file_ignore_patterns = {},
        },
        lsp_implementations = {
          file_ignore_patterns = {},
        },
        lsp_type_definitions = {
          file_ignore_patterns = {},
        },
      },
    }

    local builtin = require "telescope.builtin"

    telescope.load_extension "fzf"
    telescope.load_extension "ui-select"
    telescope.load_extension "file_browser"
    telescope.load_extension "undo"
    telescope.load_extension "live_grep_args"

    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>sgg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>sgs", builtin.grep_string, { desc = "Grep String" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Helpers" })
    vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })

    vim.keymap.set(
      "n",
      "<leader>sgl",
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      { desc = "live grep args" }
    )

    vim.keymap.set("n", "<leader>su", telescope.extensions.undo.undo, { desc = "undo" })

    vim.keymap.set(
      "n",
      "<leader>sy",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
      { desc = "File Browser" }
    )
    vim.keymap.set("n", "<leader>sY", "<cmd>Telescope file_browser<cr>", { desc = "File Browser (cwd)" })

    telescope.load_extension "git_file_history"
  end,
}
