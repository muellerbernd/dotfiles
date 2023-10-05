return {
  'rktjmp/lush.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local set = vim.o

    -- use colorscheme
    set.termguicolors = true
    set.background = 'dark'
    set.cursorline = true
    -- include our theme file and pass it to lush to apply
    require 'lush'(require 'bemu.lush_theme.gruvy')
  end,
}
