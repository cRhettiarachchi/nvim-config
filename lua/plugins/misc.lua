-- Window navigation from Visual mode that keeps the selection.
--
-- Neovim ends Visual mode as soon as the cursor lands in a window that shows a
-- different buffer (for example the Claude Code terminal), so the highlight
-- disappears. The helpers below leave Visual mode cleanly, navigate, paint the
-- range with the Visual highlight while the window is not current, and restore
-- the real selection with `gv` when that window is entered again.
local ns = vim.api.nvim_create_namespace "tmux_navigator_visual"
local held = {} -- window id -> { buf = bufnr, tick = changedtick }

local function hold_selection(win, buf)
  local start_pos, end_pos, vmode
  vim.api.nvim_buf_call(buf, function()
    start_pos, end_pos, vmode = vim.fn.getpos "'<", vim.fn.getpos "'>", vim.fn.visualmode()
  end)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  vim.hl.range(buf, ns, "Visual", { start_pos[2] - 1, start_pos[3] - 1 }, { end_pos[2] - 1, end_pos[3] - 1 }, {
    regtype = vmode,
    inclusive = vim.o.selection ~= "exclusive",
  })
  held[win] = { buf = buf, tick = vim.api.nvim_buf_get_changedtick(buf) }
end

-- Drops the held selection for `win`. With `restore`, re-enters Visual mode on
-- it, unless the buffer changed meanwhile (the range would no longer match).
local function release_selection(win, restore)
  local entry = held[win]
  if not entry then return end
  held[win] = nil
  if not vim.api.nvim_buf_is_valid(entry.buf) then return end
  vim.api.nvim_buf_clear_namespace(entry.buf, ns, 0, -1)
  if not restore then return end
  -- Re-select once the command that entered the window has finished (when
  -- coming from the terminal, Neovim is still in Terminal mode at this point).
  vim.schedule(function()
    local mode = vim.api.nvim_get_mode()
    if
      vim.api.nvim_get_current_win() == win
      and vim.api.nvim_win_get_buf(win) == entry.buf
      and vim.api.nvim_buf_get_changedtick(entry.buf) == entry.tick
      and mode.mode == "n"
      and not mode.blocking
    then
      pcall(vim.cmd, "normal! gv")
    end
  end)
end

local function navigate_from_visual(direction)
  local win, buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
  -- Leave Visual mode first so `'<`, `'>` and `gv` are set, and so plugins that
  -- watch ModeChanged (claudecode.nvim selection tracking) flush the selection
  -- while this buffer is still current.
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  vim.cmd("TmuxNavigate" .. direction)
  local new_win = vim.api.nvim_get_current_win()
  if new_win == win or vim.api.nvim_win_get_buf(new_win) == buf then
    -- Still here (tmux pane switch, or nothing that way) or another window on
    -- the same buffer: Neovim keeps Visual mode in these cases, so re-select.
    vim.cmd "normal! gv"
    return
  end
  hold_selection(win, buf)
end

return {
  {
    -- Tmux & split window navigation
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    init = function()
      -- The plugin's built-in terminal-mode mappings (only set inside tmux) use
      -- Vim's `<C-w>:` termwinkey sequence, which Neovim does not support. The
      -- keys are typed into the running program instead, so pressing <C-h> in
      -- the Claude Code terminal submitted "TmuxNavigateLeft" as a prompt.
      -- Disable them and define Neovim-compatible mappings in `keys` below.
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      local group = vim.api.nvim_create_augroup("tmux_navigator_visual", { clear = true })
      vim.api.nvim_create_autocmd("WinEnter", {
        group = group,
        desc = "Restore a Visual selection held while the window was not current",
        callback = function() release_selection(vim.api.nvim_get_current_win(), true) end,
      })
      vim.api.nvim_create_autocmd("WinClosed", {
        group = group,
        desc = "Drop the held Visual selection of a closed window",
        callback = function(args) release_selection(tonumber(args.match), false) end,
      })
    end,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" }, desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" }, desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" }, desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" }, desc = "Navigate right" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate previous" },
      -- Visual mode: navigate and keep the selection (see the helpers above)
      { "<C-h>", function() navigate_from_visual "Left" end, mode = "x", desc = "Navigate left, keep selection" },
      { "<C-j>", function() navigate_from_visual "Down" end, mode = "x", desc = "Navigate down, keep selection" },
      { "<C-k>", function() navigate_from_visual "Up" end, mode = "x", desc = "Navigate up, keep selection" },
      { "<C-l>", function() navigate_from_visual "Right" end, mode = "x", desc = "Navigate right, keep selection" },
    },
  },
}
