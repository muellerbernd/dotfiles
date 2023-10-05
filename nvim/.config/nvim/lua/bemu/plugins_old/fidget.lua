require('fidget').setup {
  text = {
    spinner = 'dots_snake',
  },
  -- -- window = {
  -- --     -- blend = 100,
  -- --     blend = 1,
  -- -- },
  window = { winblend = 0, border = 'none' },
  fmt = {
    task = function(task_name, message, percentage)
      if #message > 42 then
        message = string.format('%.39s...', message)
      end
      if #task_name > 42 then
        task_name = string.format('%.39s...', task_name)
      end
      return string.format('%s%s [%s]', message, percentage and string.format(' (%s%%)', percentage) or '', task_name)
    end,
  },
}
-- vim.cmd[[highlight FidgetTitle ctermfg=110 guifg=#6cb6eb]]
-- vim.cmd[[highlight FidgetTask ctermfg=110 guifg=#6cb6eb]]
