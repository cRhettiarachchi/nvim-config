return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      {
        'github/copilot.vim',
        config = function()
          vim.g.copilot_no_tab_map = true
          vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', {
            expr = true,
            silent = true,
            noremap = true,
          })
        end,
      }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken',
    opts = {
      prompts = {
        Rename = {
          prompt = 'Please rename the variable correctly in given selection based on context',
          selection = function(source)
            local select = require 'CopilotChat.select'
            return select.visual(source)
          end,
        },
      },
    },
    keys = {
      { '<leader>cc', ':CopilotChatToggle<CR>', mode = 'n', desc = 'Toggle Copilot Chat' },
      {
        '<leader>cc',
        function()
          local selection = vim.fn.getreg '"'
          vim.ui.input({ prompt = 'What do you want to ask Copilot?' }, function(user_input)
            local full_prompt = selection
            if user_input and user_input ~= '' then
              full_prompt = selection .. '\n\n' .. user_input
            end
            require('CopilotChat').ask(full_prompt)
          end)
        end,
        mode = 'v',
        desc = 'Ask CopilotChat with context',
        noremap = true,
        silent = true,
      },
      { '<leader>zc', ':CopilotChat<CR>', mode = 'n', desc = 'Chat with Copilot' },
      { '<leader>zc', ':CopilotChat<CR>', mode = 'v', desc = 'Chat with Copilot' },
      { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
      { '<leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
      { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issues' },
      { '<leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
      { '<leader>zd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Generate Docs' },
      { '<leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
      { '<leader>zm', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit Message' },
      { '<leader>zm', ':CopilotChatCommit<CR>', mode = 'v', desc = 'Generate Commit for Selection' },
      { '<leader>zn', ':CopilotChatRename<CR>', mode = 'v', desc = 'Rename the variable' },
    },
  },
}
