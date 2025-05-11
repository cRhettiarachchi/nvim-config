-- Cool Night Neovim Theme
-- Inspired by Josean Martinez's Alacritty scheme

local M = {}

local colors = {
  bg = 'NONE',
  fg = '#CBE0F0',
  cursor = '#47FF9C',
  black = '#214969',
  red = '#E52E2E',
  green = '#44FFB1',
  yellow = '#FFE073',
  blue = '#0FC5ED',
  purple = '#A277FF',
  cyan = '#24EAF7',
  white = '#CBE0F0',
  bright_black = '#214969',
  bright_blue = '#A277FF',
  comment_fg = '#436a8c',
  selection = '#1b3955',
  visual = '#234466',
  pmenu = '#01203a',
  special = '#FFE073',
}

function M.setup()
  -- Reset all highlighting to defaults
  vim.cmd 'highlight clear'

  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  vim.g.colors_name = 'cool_night'
  vim.o.termguicolors = true
  vim.o.background = 'dark'

  local function hi(group, opts)
    local options = {}
    options.fg = opts.fg or 'NONE'
    options.bg = opts.bg or 'NONE'

    -- Convert style to individual attributes
    if opts.style then
      if opts.style:find 'bold' then
        options.bold = true
      end
      if opts.style:find 'italic' then
        options.italic = true
      end
      if opts.style:find 'underline' then
        options.underline = true
      end
      if opts.style:find 'strikethrough' then
        options.strikethrough = true
      end
      if opts.style:find 'reverse' then
        options.reverse = true
      end
      if opts.style:find 'nocombine' then
        options.nocombine = true
      end
    end

    vim.api.nvim_set_hl(0, group, options)
  end

  -- Editor highlights
  hi('Normal', { fg = colors.fg, bg = colors.bg })
  hi('NormalFloat', { fg = colors.fg, bg = colors.bg })
  hi('ColorColumn', { bg = colors.black })
  hi('Cursor', { fg = colors.bg, bg = colors.cursor })
  hi('CursorLine', { bg = colors.black })
  hi('CursorColumn', { bg = colors.black })
  hi('Directory', { fg = colors.blue })
  hi('DiffAdd', { fg = colors.green, bg = colors.bg })
  hi('DiffChange', { fg = colors.yellow, bg = colors.bg })
  hi('DiffDelete', { fg = colors.red, bg = colors.bg })
  hi('DiffText', { fg = colors.blue, bg = colors.bg })
  hi('EndOfBuffer', { fg = colors.black })
  hi('ErrorMsg', { fg = colors.red })
  hi('VertSplit', { fg = colors.black })
  hi('Folded', { fg = colors.comment_fg, bg = colors.bg })
  hi('FoldColumn', { fg = colors.comment_fg })
  hi('SignColumn', { fg = colors.fg })
  hi('IncSearch', { fg = colors.bg, bg = colors.yellow })
  hi('LineNr', { fg = colors.comment_fg })
  hi('CursorLineNr', { fg = colors.cyan })
  hi('MatchParen', { fg = colors.cyan, style = 'bold' })
  hi('ModeMsg', { fg = colors.green })
  hi('MoreMsg', { fg = colors.green })
  hi('NonText', { fg = colors.comment_fg })
  hi('Pmenu', { fg = colors.fg, bg = colors.pmenu })
  hi('PmenuSel', { fg = colors.bg, bg = colors.blue })
  hi('PmenuSbar', { bg = colors.black })
  hi('PmenuThumb', { bg = colors.black })
  hi('Question', { fg = colors.purple })
  hi('Search', { fg = colors.bg, bg = colors.yellow })
  hi('SpecialKey', { fg = colors.special })
  hi('SpellBad', { fg = colors.red, style = 'underline' })
  hi('SpellCap', { fg = colors.yellow })
  hi('SpellLocal', { fg = colors.yellow })
  hi('SpellRare', { fg = colors.yellow })
  hi('StatusLine', { fg = colors.fg, bg = colors.black })
  hi('StatusLineNC', { fg = colors.comment_fg, bg = colors.black })
  hi('TabLine', { fg = colors.comment_fg, bg = colors.black })
  hi('TabLineFill', { bg = colors.bg })
  hi('TabLineSel', { fg = colors.fg, bg = colors.bg })
  hi('Title', { fg = colors.green })
  hi('Visual', { bg = colors.visual })
  hi('VisualNOS', { bg = colors.visual })
  hi('WarningMsg', { fg = colors.yellow })
  hi('WildMenu', { fg = colors.bg, bg = colors.blue })

  -- Syntax highlighting
  hi('Comment', { fg = colors.comment_fg, style = 'italic' })
  hi('Constant', { fg = colors.cyan })
  hi('String', { fg = colors.green })
  hi('Character', { fg = colors.green })
  hi('Number', { fg = colors.yellow })
  hi('Boolean', { fg = colors.yellow })
  hi('Float', { fg = colors.yellow })
  hi('Identifier', { fg = colors.purple })
  hi('Function', { fg = colors.blue })
  hi('Statement', { fg = colors.purple })
  hi('Conditional', { fg = colors.purple })
  hi('Repeat', { fg = colors.purple })
  hi('Label', { fg = colors.purple })
  hi('Operator', { fg = colors.cyan })
  hi('Keyword', { fg = colors.purple })
  hi('Exception', { fg = colors.purple })
  hi('PreProc', { fg = colors.purple })
  hi('Include', { fg = colors.blue })
  hi('Define', { fg = colors.purple })
  hi('Macro', { fg = colors.purple })
  hi('PreCondit', { fg = colors.purple })
  hi('Type', { fg = colors.blue })
  hi('StorageClass', { fg = colors.purple })
  hi('Structure', { fg = colors.purple })
  hi('Typedef', { fg = colors.purple })
  hi('Special', { fg = colors.cyan })
  hi('SpecialChar', { fg = colors.cyan })
  hi('Tag', { fg = colors.cyan })
  hi('Delimiter', { fg = colors.cyan })
  hi('SpecialComment', { fg = colors.comment_fg })
  hi('Debug', { fg = colors.red })
  hi('Underlined', { style = 'underline' })
  hi('Ignore', {})
  hi('Error', { fg = colors.red })
  hi('Todo', { fg = colors.yellow, style = 'bold' })

  -- LSP Diagnostics
  hi('DiagnosticError', { fg = colors.red })
  hi('DiagnosticWarn', { fg = colors.yellow })
  hi('DiagnosticInfo', { fg = colors.blue })
  hi('DiagnosticHint', { fg = colors.cyan })
  hi('DiagnosticUnderlineError', { fg = colors.red, style = 'underline' })
  hi('DiagnosticUnderlineWarn', { fg = colors.yellow, style = 'underline' })
  hi('DiagnosticUnderlineInfo', { fg = colors.blue, style = 'underline' })
  hi('DiagnosticUnderlineHint', { fg = colors.cyan, style = 'underline' })

  -- Treesitter
  hi('TSAttribute', { fg = colors.yellow })
  hi('TSBoolean', { fg = colors.yellow })
  hi('TSCharacter', { fg = colors.green })
  hi('TSComment', { fg = colors.comment_fg, style = 'italic' })
  hi('TSConstructor', { fg = colors.blue })
  hi('TSConditional', { fg = colors.purple })
  hi('TSConstant', { fg = colors.cyan })
  hi('TSConstBuiltin', { fg = colors.yellow })
  hi('TSConstMacro', { fg = colors.yellow })
  hi('TSError', { fg = colors.red })
  hi('TSException', { fg = colors.purple })
  hi('TSField', { fg = colors.fg })
  hi('TSFloat', { fg = colors.yellow })
  hi('TSFunction', { fg = colors.blue })
  hi('TSFuncBuiltin', { fg = colors.blue })
  hi('TSFuncMacro', { fg = colors.blue })
  hi('TSInclude', { fg = colors.purple })
  hi('TSKeyword', { fg = colors.purple })
  hi('TSKeywordFunction', { fg = colors.purple })
  hi('TSKeywordOperator', { fg = colors.purple })
  hi('TSLabel', { fg = colors.purple })
  hi('TSMethod', { fg = colors.blue })
  hi('TSNamespace', { fg = colors.cyan })
  hi('TSNone', { fg = colors.fg })
  hi('TSNumber', { fg = colors.yellow })
  hi('TSOperator', { fg = colors.cyan })
  hi('TSParameter', { fg = colors.fg })
  hi('TSParameterReference', { fg = colors.fg })
  hi('TSProperty', { fg = colors.fg })
  hi('TSPunctDelimiter', { fg = colors.cyan })
  hi('TSPunctBracket', { fg = colors.cyan })
  hi('TSPunctSpecial', { fg = colors.cyan })
  hi('TSRepeat', { fg = colors.purple })
  hi('TSString', { fg = colors.green })
  hi('TSStringRegex', { fg = colors.green })
  hi('TSStringEscape', { fg = colors.green })
  hi('TSSymbol', { fg = colors.cyan })
  hi('TSTag', { fg = colors.red })
  hi('TSTagDelimiter', { fg = colors.cyan })
  hi('TSText', { fg = colors.fg })
  hi('TSStrong', { fg = colors.fg, style = 'bold' })
  hi('TSEmphasis', { fg = colors.fg, style = 'italic' })
  hi('TSUnderline', { fg = colors.fg, style = 'underline' })
  hi('TSStrike', { fg = colors.fg, style = 'strikethrough' })
  hi('TSTitle', { fg = colors.green })
  hi('TSLiteral', { fg = colors.green })
  hi('TSURI', { fg = colors.green, style = 'underline' })
  hi('TSType', { fg = colors.blue })
  hi('TSTypeBuiltin', { fg = colors.blue })
  hi('TSVariable', { fg = colors.fg })
  hi('TSVariableBuiltin', { fg = colors.yellow })

  -- Common plugin-specific groups
  -- Git
  hi('diffAdded', { fg = colors.green })
  hi('diffRemoved', { fg = colors.red })
  hi('gitcommitComment', { fg = colors.comment_fg })
  hi('gitcommitUntracked', { fg = colors.comment_fg })
  hi('gitcommitDiscarded', { fg = colors.comment_fg })
  hi('gitcommitSelected', { fg = colors.comment_fg })
  hi('gitcommitHeader', { fg = colors.purple })
  hi('gitcommitSelectedType', { fg = colors.blue })
  hi('gitcommitUnmergedType', { fg = colors.blue })
  hi('gitcommitDiscardedType', { fg = colors.blue })
  hi('gitcommitBranch', { fg = colors.yellow, style = 'bold' })
  hi('gitcommitUntrackedFile', { fg = colors.cyan })
  hi('gitcommitUnmergedFile', { fg = colors.red, style = 'bold' })
  hi('gitcommitDiscardedFile', { fg = colors.red, style = 'bold' })
  hi('gitcommitSelectedFile', { fg = colors.green, style = 'bold' })

  -- NvimTree
  hi('NvimTreeFolderName', { fg = colors.blue })
  hi('NvimTreeFolderIcon', { fg = colors.blue })
  hi('NvimTreeNormal', { fg = colors.fg, bg = colors.bg })
  hi('NvimTreeOpenedFolderName', { fg = colors.blue, style = 'bold' })
  hi('NvimTreeEmptyFolderName', { fg = colors.comment_fg })
  hi('NvimTreeIndentMarker', { fg = colors.black })
  hi('NvimTreeGitDirty', { fg = colors.yellow })
  hi('NvimTreeGitNew', { fg = colors.green })
  hi('NvimTreeGitDeleted', { fg = colors.red })
  hi('NvimTreeSpecialFile', { fg = colors.purple, style = 'underline' })
  hi('NvimTreeRootFolder', { fg = colors.cyan })

  -- Telescope
  hi('TelescopeNormal', { fg = colors.fg })
  hi('TelescopeBorder', { fg = colors.comment_fg })
  hi('TelescopePromptBorder', { fg = colors.blue })
  hi('TelescopeResultsBorder', { fg = colors.comment_fg })
  hi('TelescopePreviewBorder', { fg = colors.comment_fg })
  hi('TelescopeSelectionCaret', { fg = colors.blue })
  hi('TelescopeSelection', { fg = colors.fg, bg = colors.selection })
  hi('TelescopeMatching', { fg = colors.yellow, style = 'bold' })

  -- Other
  hi('IndentBlanklineChar', { fg = colors.black, style = 'nocombine' })
end

return M
