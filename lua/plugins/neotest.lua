return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-jest' {
          jestCommand = 'npm test --', -- Use Pecker for faster Jest execution
          jestConfigFile = 'jest.config.js', -- Adjust if needed
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
    }
    vim.keymap.set('n', '<leader>tt', function()
      require('neotest').run.run()
    end, { desc = '[T]est [T]his - Run nearest test' })

    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[T]est [F]ile - Run all tests in file' })

    vim.keymap.set('n', '<leader>to', function()
      require('neotest').output.open()
    end, { desc = '[T]est [O]utput - Show test results' })

    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').summary.toggle()
    end, { desc = '[T]est [S]ummary - Show test summary' })
  end,
}
