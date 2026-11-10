return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    picker = "telescope",
    -- bare `:Octo` command opens a picker of subcommands
    enable_builtin = true,
  },
  keys = {
    { "<leader>oh", nil, desc = "GitHub (Octo)" },
    -- Reviewing: pick a PR (<CR> in the list = open its buffer), then
    -- `ohr` reviews whichever PR buffer you're in (falls back to the PR
    -- for your current git branch if you're not in one).
    { "<leader>ohp", "<cmd>Octo pr list<cr>", desc = "GitHub: PR list (<CR> to pick)" },
    { "<leader>ohr", "<cmd>Octo review<cr>", desc = "GitHub: Start/resume PR review" },
    { "<leader>ohs", "<cmd>Octo review submit<cr>", desc = "GitHub: Submit PR review" },
    { "<leader>ohd", "<cmd>Octo review discard<cr>", desc = "GitHub: Discard PR review" },
    -- Raising: open a PR for whatever branch you're currently on.
    { "<leader>ohc", "<cmd>Octo pr create<cr>", desc = "GitHub: Create PR" },
  },
}
