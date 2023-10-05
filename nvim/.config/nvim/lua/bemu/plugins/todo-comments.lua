return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = true,
  dependencies = 'nvim-lua/plenary.nvim',
  --     config = function()
  --       require('todo-comments').setup {}
  --     end,
  --   },
}
