-- leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

-- taken from here: https://github.com/nvim-telescope/telescope.nvim/issues/3439
-- Silence the specific position encoding message
-- local notify_original = vim.notify
-- vim.notify = function(msg, ...)
--   if
--       msg
--       and (
--         msg:match 'position_encoding param is required'
--         or msg:match 'Defaulting to position encoding of the first client'
--         or msg:match 'multiple different client offset_encodings'
--       )
--   then
--     return
--   end
--   return notify_original(msg, ...)
-- end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- setup lazy and load my lua/bemu/plugins folder
require('lazy').setup({ { import = 'bemu/plugins' } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- see full list:
      -- https://github.com/neovim/neovim/tree/master/runtime/plugin
      disabled_plugins = {
        'tohtml.lua',
        'gzip.vim',
        'man.lua',
        'tarPlugin.vim',
        'zipPlugin.vim',
        'rplugin.vim',
      },
    },
  },
})
