return {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  -- You probably also want to set a keymap to toggle aerial
  vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>'),
}
