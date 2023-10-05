-- no height for quickfixlist
-- vim.g.asyncrun_open = 0
-- vim.g.asynctasks_term_pos = 'external'
-- vim.g.asynctasks_term_pos = 'bottom'
-- vim.cmd [[
--
-- function! s:my_runner(opts)
--     lua require("asyncrun.myToggleterm").runner(vim.fn.eval("a:opts"))
-- endfunction
--
-- let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
-- let g:asyncrun_runner.test = function('s:my_runner')
--     ]]
-- vim.g.asynctasks_term_pos = "test"
-- vim.g.asynctasks_term_pos = "toggleterm"
--
vim.g.asyncrun_open = 0

vim.g.asynctasks_term_close = 1
