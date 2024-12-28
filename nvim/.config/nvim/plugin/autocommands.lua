local group = vim.api.nvim_create_augroup('BEMU', { clear = true })
local funcs = require 'bemu.core.funcs'
-- open help in right split
-- vim.api.nvim_create_autocmd("BufEnter", {
--     pattern = { "*.txt" },
--     group = group,
--     command = "if &buftype == 'help' | wincmd L | endif",
-- })
-- Open at last spot in line. from defaults.vim
vim.api.nvim_create_autocmd('BufReadPost', {
  group = group,
  command = 'if line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif',
})
-- play sound on save, if enabled
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = funcs.PlaySaveSound,
})
-- play sound on vim leave, if enabled
vim.api.nvim_create_autocmd('VimLeave', {
  group = group,
  callback = funcs.PlayLeaveSound,
})
-- trim white space
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = funcs.TrimWhitespace,
})
-- retab
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  -- command = "retab",
  callback = funcs.retab,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = funcs.MkNonExDir,
})

-- set filetypes for specific files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
  group = group,
  pattern = { '*.md' },
  command = 'set filetype=markdown',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
  group = group,
  pattern = { '*.launch', '*.urdf' },
  command = 'set filetype=xml',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
  group = group,
  pattern = { '*.repos', '*.rosinstall' },
  command = 'set filetype=yaml',
})

-- vim.filetype.add({
--   pattern = { ["~/.config/hypr/.*%conf"] = "hypr" },
-- })

vim.filetype.add {
  extension = { rasi = 'rasi' },
  pattern = {
    ['.*/waybar/config*'] = 'jsonc',
    ['.*/mako/config'] = 'dosini',
    ['.*/hypr/.*%.conf'] = 'hyprlang',
  },
}

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
--     group = group,
--     pattern = { "*.html.hbs" },
--     command = "set filetype=handlebars",
-- })

-- customize cmp_docs to be rendered as markdown
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'cmp_docs',
--     callback = function()
--         vim.treesitter.start(0, 'markdown')
--     end,
-- })

-- commentstring
-- https://github.com/neovim/neovim/pull/28176
-- vim.api.nvim_create_autocmd('FileType', {
--   group = group,
--   pattern = { 'hyprlang', 'dosini' },
--   callback = function(event)
--     local cs = '#%s'
--     vim.bo[event.buf].commentstring = cs:gsub('(%S)%%s', '%1 %%s'):gsub('%%s(%S)', '%%s %1')
--   end,
-- })

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('FormatOptions', { clear = true }),
  pattern = { '*' },
  callback = function()
    vim.opt_local.fo:remove 'o'
    vim.opt_local.fo:remove 'r'
  end,
})
