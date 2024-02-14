return {
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    -- config = true,
    config = function()
      local undotree = require 'undotree'
      undotree.setup {}
      vim.keymap.set('n', '<Leader>u', function()
        undotree.toggle {}
      end, { desc = '[u]ndotree toggle' })
    end,
  },
}
