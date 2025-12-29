return {
  'hrsh7th/cmp-nvim-lsp',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/lazydev.nvim', opts = {} },
    { 'yioneko/nvim-vtsls' },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- Configure vtsls with Vue TypeScript plugin support
    vim.lsp.config('vtsls', {
      capabilities = capabilities,
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              {
                configNamespace = 'typescript',
                enableForWorkspaceTypeScriptVersions = true,
                languages = { 'vue' },
                location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                name = '@vue/typescript-plugin',
              },
            },
          },
        },
      },
    })
  end,
}
