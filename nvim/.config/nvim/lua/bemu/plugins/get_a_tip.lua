return {
  {
    -- idea taken from here
    -- https://www.reddit.com/r/neovim/comments/17qdqkt/get_a_handy_tip_when_you_launch_neovim/
    'rcarriga/nvim-notify',
    init = function()
      vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
      vim.notify = require 'notify'
    end,
    config = function(_, opts)
      require('notify').setup {
        background_colour = '#000000',
      }
      local job = require 'plenary.job'
      job
        :new({
          command = 'curl',
          args = { 'https://vtip.43z.one' },
          on_exit = function(j, exit_code)
            local res = table.concat(j:result())
            if exit_code ~= 0 then
              res = 'Error fetching tip: ' .. res
            end
            require 'notify'(res)
          end,
        })
        :start()
    end,
  },
}
