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
-- vim.o.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- -- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
-- vim.opt.foldenable = false
-- vim.opt.foldlevel = 99
--
-- -- vim.opt.foldcolumn = "0"
-- -- vim.opt.foldtext = ""
-- UFO folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '',
  foldsep = ' ',
  foldclose = ''
}
