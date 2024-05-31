-- https://www.reddit.com/r/neovim/comments/1d3iwcz/custom_folds_without_any_plugins/
-- vim.o.foldmethod = 'marker'
--
-- -- The function used to make the text
-- FoldText = function()
-- end
--
-- vim.o.foldtext = "v:lua.FoldText()"
-- -- FoldText is the function name

-- use treesitter for folding
vim.o.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.opt.foldenable = false
vim.opt.foldlevel = 99
