vim.api.nvim_create_user_command('ToggleSound', function()
  require('bemu.funcs').TogglePlaySound()
end, {})

vim.api.nvim_create_user_command('ToggleTrimWhitespace', function()
  require('bemu.funcs').ToggleTrimWhitespace()
end, {})

-- vim.api.nvim_create_user_command('NrPlugins', function()
--   print(vim.fn.len(vim.fn.globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1)))
-- end, {})

vim.api.nvim_create_user_command('NvimReload', function()
  require('bemu.funcs').reload_nvim_conf()
end, {})
