return {
  'rktjmp/lush.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- include our theme file and pass it to lush to apply
    require 'lush' (require 'bemu.lush_theme.gruvy')
  end,
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function(opts)
  --     require("gruvbox").setup(opts)
  --     vim.cmd.colorscheme("gruvbox")
  --   end,
  -- }
  -- vim.cmd.colorscheme("default")
}
