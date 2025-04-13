return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'rouge8/neotest-rust',
  },
  config = function() -- This is the function that runs, AFTER loading
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
        -- require 'neotest-plenary',
        -- require 'neotest-vim-test' {
        --   ignore_file_types = { 'python', 'vim', 'lua' },
        -- },
        require 'neotest-rust',
      },
    }
  end,
}
