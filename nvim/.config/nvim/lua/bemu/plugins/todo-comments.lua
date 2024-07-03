return {
  'folke/todo-comments.nvim',
  -- config = true,
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('todo-comments').setup {
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--no-ignore-vcs',
        },
      },
    }
    -- todo
    vim.keymap.set('n', '<leader>td', '<cmd>TodoTelescope<CR>', { desc = 'list current [t]o[d]os' })
  end,
}
