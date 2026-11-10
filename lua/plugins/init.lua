return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup {
        style = "night", -- darkest variant (storm/night/moon/day)
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        on_colors = function(colors)
          -- Default identifier text → Darcula's calm blue-grey (kills the "all blue" look,
          -- since tokyonight links variables/params/identifiers to fg).
          colors.fg = "#A9B7C6"
          colors.fg_dark = "#8A97A8"

          -- IntelliJ Darcula backgrounds, nudged a touch darker.
          colors.bg = "#242424" -- main editor background (Darcula #2B2B2B, slightly darker)
          colors.bg_dark = "#34373A" -- sidebars / nvim-tree (Darcula tool windows)
          colors.bg_float = "#34373A" -- floating windows
          colors.bg_popup = "#34373A"
          colors.bg_sidebar = "#34373A"
          colors.bg_statusline = "#34373A"
          colors.bg_highlight = "#2C2C2C" -- current-line / visual highlight
        end,
        -- IntelliJ Darcula syntax palette. Color is reserved for meaning; plain
        -- identifiers stay blue-grey so the overall look isn't blue-dominated.
        on_highlights = function(hl)
          local darcula = {
            fg = "#A9B7C6", -- identifiers, variables, params, operators
            keyword = "#CC7832", -- orange: keywords, booleans, builtins
            string = "#6A8759", -- olive green
            number = "#6897BB", -- muted blue
            func = "#FFC66D", -- gold
            field = "#B083D0", -- purple (lifted from Darcula #9876AA for AA contrast)
            comment = "#808080", -- grey
            doc = "#629755", -- green italic doc comments
            annotation = "#BBB529", -- yellow-green
            escape = "#CC7832",
          }
          local p = darcula

          -- Comments
          hl.Comment = { fg = p.comment, italic = false }
          hl["@comment"] = { fg = p.comment, italic = false }
          hl["@comment.documentation"] = { fg = p.doc, italic = true }

          -- Keywords / control flow (orange)
          for _, g in ipairs {
            "Keyword", "Statement", "Conditional", "Repeat", "Exception", "Include",
            "@keyword", "@keyword.function", "@keyword.operator", "@keyword.return",
            "@keyword.import", "@keyword.repeat", "@keyword.conditional", "@keyword.exception",
            "@conditional", "@repeat", "@exception", "@storageclass", "@type.qualifier",
          } do
            hl[g] = { fg = p.keyword }
          end

          -- Builtins / booleans / builtin constants (orange)
          hl.Boolean = { fg = p.keyword }
          hl["@boolean"] = { fg = p.keyword }
          hl["@constant.builtin"] = { fg = p.keyword }
          hl["@type.builtin"] = { fg = p.keyword }
          hl["@string.escape"] = { fg = p.escape }

          -- Strings (olive green)
          hl.String = { fg = p.string }
          hl.Character = { fg = p.string }
          hl["@string"] = { fg = p.string }
          hl["@character"] = { fg = p.string }

          -- Numbers (blue)
          for _, g in ipairs { "Number", "Float", "@number", "@float", "@number.float" } do
            hl[g] = { fg = p.number }
          end

          -- Functions / methods (gold)
          for _, g in ipairs {
            "Function", "@function", "@function.call", "@function.method",
            "@function.method.call", "@function.builtin",
          } do
            hl[g] = { fg = p.func }
          end
          hl["@constructor"] = { fg = p.fg } -- Darcula leaves constructors default

          -- Fields / properties / constants (purple)
          hl["@field"] = { fg = p.field }
          hl["@property"] = { fg = p.field }
          hl["@variable.member"] = { fg = p.field }
          hl.Constant = { fg = p.field, italic = true }
          hl["@constant"] = { fg = p.field, italic = true }

          -- Types / classes / namespaces → default text (Darcula keeps these neutral)
          for _, g in ipairs { "Type", "@type", "@type.definition", "@namespace", "@module" } do
            hl[g] = { fg = p.fg }
          end

          -- Plain identifiers, variables, params, operators, punctuation → blue-grey
          for _, g in ipairs {
            "Identifier", "@variable", "@variable.parameter", "@parameter",
            "Operator", "@operator", "@punctuation", "@punctuation.bracket",
            "@punctuation.delimiter", "@punctuation.special",
          } do
            hl[g] = { fg = p.fg }
          end

          -- Annotations / decorators / preprocessor (yellow-green)
          for _, g in ipairs { "@attribute", "@annotation", "PreProc", "Macro", "Define" } do
            hl[g] = { fg = p.annotation }
          end

          -- Markup tags (HTML/JSX) — Darcula tag styling
          hl["@tag"] = { fg = "#E8BF6A" }
          hl["@tag.attribute"] = { fg = "#BABABA" }
          hl["@tag.delimiter"] = { fg = p.fg }

          -- Focused window slightly darker than inactive splits.
          hl.Normal = { fg = p.fg, bg = "#1F1F1F" } -- active window
          hl.NormalNC = { fg = p.fg, bg = "#242424" } -- inactive windows (base bg)
        end,
      }
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
  { "folke/which-key.nvim" },
}
