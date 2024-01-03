return {
  'muellerbernd/latex-previewer.nvim',
  -- latex-previewer
  vim.keymap.set('n', '<F5>', "<cmd>lua require('latex-previewer').preview()<cr>", { desc = 'open latex-previewer' }),
}
