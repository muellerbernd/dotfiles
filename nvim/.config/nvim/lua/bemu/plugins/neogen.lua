return {
  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    -- config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    -- config = true,
    config = function()
      local neogen = require 'neogen'
      neogen.setup {}
      vim.keymap.set('n', '<Leader>ng', function()
        neogen.generate {}
      end, { desc = '[n]eogen generate' })
    end,
  },
}
