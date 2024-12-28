return {
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  --   ft = { 'markdown' },
  --   build = function()
  --     vim.fn['mkdp#util#install']()
  --   end,
  -- },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    config = function()
      -- markdown-previewer
      vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'toggle [m]arkdown-[p]reviewer' })
    end,
    ft = { 'markdown' },
  },
  -- 'FelipeIzolan/markviewer.nvim',
  -- config = function()
  --   require('markviewer').setup()
  -- end,
  -- { 'ellisonleao/glow.nvim', config = true, cmd = 'Glow' },
}
