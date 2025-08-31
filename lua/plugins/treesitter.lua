return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = function()
    -- Define core web development parsers - these load immediately
    local core_parsers = {
      'javascript',
      'typescript',
      'tsx',
      'html',
      'css',
      'json',
      'lua', -- for config files
    }

    -- Define extended parsers - these load on demand
    local extended_parsers = {
      'python',
      'vimdoc',
      'vim',
      'regex',
      -- 'terraform',
      'sql',
      'dockerfile',
      'toml',
      'java',
      'groovy',
      -- 'go',
      'gitignore',
      'graphql',
      'yaml',
      'make',
      'cmake',
      'markdown',
      'markdown_inline',
      'bash',
    }

    return {
      ensure_installed = vim.list_extend(core_parsers, extended_parsers),
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    }
  end,
}
