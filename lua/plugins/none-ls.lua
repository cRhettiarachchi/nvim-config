return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim',
    'davidmh/cspell.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local cspell = require 'cspell'

    -- Formatters & Linters for Mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'shfmt',
        'checkmake',
        'ruff',
      },
      automatic_installation = true,
    }

    local function get_cspell_config()
      local cwd = vim.fn.getcwd()
      local config = cwd .. '/cspell.json'
      if vim.fn.filereadable(config) == 1 then
        return config
      end
      return nil
    end

    -- Optional: Define advanced config (can be expanded if needed)
    local cspell_config = {
      config_file_preferred_name = 'cspell.json',
      cspell_config_dirs = { vim.fn.expand '~/.config/' },
      read_config_synchronously = true,

      on_add_to_json = function(payload)
        os.execute(
          string.format(
            "jq -S '.words |= sort' %s > %s.tmp && mv %s.tmp %s",
            payload.cspell_config_path,
            payload.cspell_config_path,
            payload.cspell_config_path,
            payload.cspell_config_path
          )
        )
      end,
    }

    -- Configure null-ls sources (excluding eslint_d)
    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with {
        filetypes = { 'html', 'json', 'yaml', 'markdown', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
        prefer_local = 'node_modules/.bin',
      },
      null_ls.builtins.diagnostics.codespell.with {
        filetypes = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'lua', 'python', 'markdown' },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',

      -- 🧠 Add CSpell diagnostics + code actions
      cspell.diagnostics.with {
        config = cspell_config,
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
      },
      cspell.code_actions.with { config = cspell_config },
    }

    -- null-ls setup
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                async = false,
                filter = function(client)
                  return client.name == 'null-ls'
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
