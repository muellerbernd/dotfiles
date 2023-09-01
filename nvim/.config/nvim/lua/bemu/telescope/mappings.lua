if not pcall(require, 'telescope') then
  return
end

-- local sorters = require("telescope.sorters")

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer, opts)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = 'n'
  local rhs = string.format("<cmd>lua R('bemu.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = { noremap = true }
  if opts then
    map_options = vim.tbl_extend('force', map_options, opts)
  end

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

-- vim.api.nvim_set_keymap('c', '<c-r><c-r>',
--                         '<Plug>(TelescopeFuzzyCommandSearch)',
--                         {noremap = false, nowait = true})

-- Dotfiles
-- map_tele('<leader>en', 'edit_neovim')
-- map_tele('<leader>fa', 'installed_plugins')
-- map_tele('<leader>fk', 'lsp_code_actions')
-- map_tele('<leader>fr', 'file_browser')
-- -- Telescope Meta
-- map_tele('<leader>fB', 'builtin')
-- map_tele('<leader>fT', 'treesitter')
return map_tele
