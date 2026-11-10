return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Navigation (respects diff mode)
      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(gs.next_hunk)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(gs.prev_hunk)
        return "<Ignore>"
      end, { expr = true })

      -- Actions, all grouped under <leader>gs(letter)
      map("n", "<leader>gss", gs.stage_hunk)
      map("n", "<leader>gsu", gs.undo_stage_hunk)
      map("n", "<leader>gsp", gs.preview_hunk)
      map("n", "<leader>gsi", gs.preview_hunk_inline)
      map("n", "<leader>gsw", gs.toggle_word_diff)
      map("n", "<leader>gsq", function() gs.setqflist "all" end, { desc = "All Workspace Hunks to Quickfix" })
      map("n", "<leader>gsb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
    end,
  },
}
