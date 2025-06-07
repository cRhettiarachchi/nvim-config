return {
  'esmuellert/nvim-eslint',
  event = { 'BufReadPre', 'BufNewFile' },

  cond = function()
    -- Check if package.json exists
    if vim.fn.filereadable 'package.json' == 0 then
      return false
    end

    -- Check if `eslint` or `eslint-config` or similar is in dependencies or devDependencies
    local package_json = vim.fn.readfile 'package.json'
    local package_text = table.concat(package_json, '\n')

    return package_text:match '"eslint"' ~= nil
  end,

  config = function()
    local nvim_eslint = require 'nvim-eslint'
    nvim_eslint.setup {
      debug = false,
      settings = {
        useESLintClass = true,
        -- STATIC boolean values only
        -- useFlatConfig = true,
        -- experimental = { useFlatConfig = false }, -- leave false for ESLint 9
        format = false,
        codeActionOnSave = { enable = true, mode = 'all' },
        workingDirectory = {
          -- Here, use the proper format: pass a static table
          mode = 'auto', -- or 'location', or...
          -- OR if you want to pass a custom directory path:
          -- directory = '/Users/charith/your-monorepo/packages/foo'
        },
      },
    }
  end,
}
