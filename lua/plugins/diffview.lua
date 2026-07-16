return {
  "sindrets/diffview.nvim",

  opts = {
    keymaps = {
      view = {
        {
          "n",
          "<leader>go",
          function()
            local view = require("diffview.lib").get_current_view()
            local entry = view and view.cur_entry
            if entry and entry.path then
              vim.cmd("tabedit " .. vim.fn.fnameescape(entry.path))
            end
          end,
          { desc = "Open file in new tab" },
        },
      },
      file_panel = {
        {
          "n",
          "<leader>go",
          function()
            local view = require("diffview.lib").get_current_view()
            local entry = view and view.cur_entry
            if entry and entry.path then
              vim.cmd("tabedit " .. vim.fn.fnameescape(entry.path))
            end
          end,
          { desc = "Open file in new tab" },
        },
      },
    },
  },

  init = function()
    vim.keymap.set({ "n", "v" }, "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff View open" })
    vim.keymap.set({ "n", "v" }, "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Diff View close" })
    vim.keymap.set({ "n", "v" }, "<leader>gf", "<cmd>DiffviewFileHistory<cr>", { desc = "Diff View file" })

    vim.keymap.set("n", "<leader>tc", function()
      local bufname = vim.api.nvim_buf_get_name(0)

      if bufname:match "diffview" then
        vim.cmd "DiffviewClose"
      else
        vim.cmd "tabclose"
      end
    end, { desc = "Close tab (smart)" })
  end,
}
