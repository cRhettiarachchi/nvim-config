-- Godot integration.
--
-- Two directions to wire up:
--   * Godot -> Neovim: clicking a script in the Godot editor opens it in this
--     running instance, via a socket at <project>/godothost. Run `:GodotSetup`
--     for the exact Editor Settings to paste.
--   * Neovim -> Godot: `:GodotRun`, `:GodotRunScene` and `:GodotEditor` launch
--     the engine without leaving the buffer.
--
-- The GDScript language server *is* the Godot editor (TCP 6005), enabled in
-- `lua/lsp.lua` -- completion and diagnostics only work while Godot is open.

local godot_bin = vim.env.GODOT_BIN or "/Applications/Godot.app/Contents/MacOS/Godot"

--- Directory holding project.godot, searching upward from `start`.
---@return string?
local function project_root(start)
  local found = vim.fs.find("project.godot", { upward = true, path = start or vim.fn.getcwd() })[1]
  return found and vim.fs.dirname(found) or nil
end

--- True when nothing is listening on `pipe` (left over from a crashed nvim).
local function is_stale(pipe)
  local ok, chan = pcall(vim.fn.sockconnect, "pipe", pipe, { rpc = true })
  if ok and chan ~= 0 then
    pcall(vim.fn.chanclose, chan)
    return false
  end
  return true
end

--- Listen on <root>/godothost so Godot's --server flag can reach this instance.
local function serve(root)
  local pipe = root .. "/godothost"
  if vim.uv.fs_stat(pipe) and is_stale(pipe) then vim.uv.fs_unlink(pipe) end
  -- A live socket means another nvim already owns this project; leave it alone.
  pcall(vim.fn.serverstart, pipe)
end

--- Run the Godot binary against the current project, detached from nvim.
local function launch(args, label)
  local root = project_root()
  if not root then return vim.notify("No project.godot above " .. vim.fn.getcwd(), vim.log.levels.WARN) end
  if vim.fn.executable(godot_bin) == 0 then
    return vim.notify("Godot not found at " .. godot_bin .. " -- set $GODOT_BIN", vim.log.levels.ERROR)
  end

  local cmd = vim.list_extend({ godot_bin, "--path", root }, args)
  vim.system(cmd, { detach = true }, function(out)
    if out.code ~= 0 then
      vim.schedule(
        function() vim.notify(("%s exited %d\n%s"):format(label, out.code, out.stderr or ""), vim.log.levels.ERROR) end
      )
    end
  end)
  vim.notify(label, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("GodotRun", function() launch({}, "Godot: running project") end, {
  desc = "Run the Godot project",
})

vim.api.nvim_create_user_command("GodotRunScene", function(opts)
  local scene = opts.args ~= "" and opts.args or vim.fn.expand "%:p"
  if not scene:match "%.tscn$" then return vim.notify("Not a scene file: " .. scene, vim.log.levels.WARN) end
  local root = project_root()
  if root then scene = "res://" .. vim.fs.relpath(root, scene) end
  launch({ scene }, "Godot: running " .. scene)
end, { desc = "Run a scene (defaults to the current .tscn)", nargs = "?", complete = "file" })

vim.api.nvim_create_user_command("GodotEditor", function() launch({ "--editor" }, "Godot: opening editor") end, {
  desc = "Open the project in the Godot editor",
})

vim.api.nvim_create_user_command("GodotSetup", function()
  local root = project_root()
  vim.notify(table.concat({
    "Godot -> Editor Settings -> Text Editor -> External",
    "  Use External Editor : on",
    -- exepath resolves via $PATH (/opt/homebrew/bin/nvim), which survives
    -- Neovim upgrades; v:progpath points into the versioned Cellar dir.
    "  Exec Path           : " .. (vim.fn.exepath "nvim" ~= "" and vim.fn.exepath "nvim" or vim.v.progpath),
    [[  Exec Flags          : --server {project}/godothost --remote-send "<C-\><C-N>:n {file}<CR>{line}G{col}|"]],
    "",
    "Godot -> Editor Settings -> Network -> Language Server",
    "  Remote Port         : 6005",
    "",
    root and ("This project: " .. root .. "  (add godothost to .gitignore)") or "Not inside a Godot project.",
  }, "\n"))
end, { desc = "Print the Godot Editor Settings needed for this setup" })

vim.keymap.set("n", "<leader>Gr", "<cmd>GodotRun<cr>", { silent = true, desc = "Godot run project" })
vim.keymap.set("n", "<leader>Gs", "<cmd>GodotRunScene<cr>", { silent = true, desc = "Godot run scene" })
vim.keymap.set("n", "<leader>Ge", "<cmd>GodotEditor<cr>", { silent = true, desc = "Godot open editor" })
vim.keymap.set("n", "<leader>G?", "<cmd>GodotSetup<cr>", { silent = true, desc = "Godot setup help" })

local root = project_root()
if root then serve(root) end
