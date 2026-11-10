return {
  -- `.git` is lspconfig's fallback marker, which would attach .gd files sitting
  -- outside a Godot project to whatever project the editor happens to have open.
  root_markers = { "project.godot" },
}
