return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  -- config = true,
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('todo-comments').setup {}
    -- todo
    vim.keymap.set('n', '<leader>td', '<cmd>TodoTelescope<CR>', { desc = 'list current [t]o[d]os' })
  end,
}
