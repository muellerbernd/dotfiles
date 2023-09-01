local group = vim.api.nvim_create_augroup('BEMU', { clear = true })
local funcs = require 'bemu.funcs'
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
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
--     group = group,
--     pattern = { "*.md" },
--     command = "set filetype=markdown",
-- })

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

-- in markdown jump back via backspace
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "markdown" },
--     callback = function()
--         -- mk
--         vim.api.nvim_buf_set_keymap(0, "n", "jb", ":edit #<cr>", { silent = true })
--     end,
-- })

-- local write_source = vim.api.nvim_create_augroup("WritePostReload", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     group = write_source,
--     pattern = {"*/lua/config/*.lua"},
--     callback = function(args)
--         vim.notify("now reloading nvim conf")
--         if #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) == 0 then
--             local file = vim.split(args.file, "lua/config/", { true, false })[2]
--             local config = "config." .. vim.split(file, ".lua", { true, false })[1]
--             vim.notify("now reloading nvim conf")
--             R(config)
--         end
--     end,
-- })
