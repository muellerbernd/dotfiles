return {
  {
    'ggandor/leap.nvim',
    config = function()
      local leap = require 'leap'
      leap.set_default_mappings()
      leap.opts.preview_filter = function(ch0, ch1, ch2)
        return not (ch1:match '%s' or ch0:match '%a' and ch1:match '%a' and ch2:match '%a')
      end
      leap.opts.case_sensitive = true
      -- vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
      -- vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
      -- vim.keymap.set('n', 'gs', '<Plug>(leap-from-window)')

      -- vim.keymap.set('n', 's', '<Plug>(leap-anywhere)')
      -- vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap)')
    end,
  },
}
