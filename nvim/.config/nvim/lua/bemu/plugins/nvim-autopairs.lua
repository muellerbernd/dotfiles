return {
  'windwp/nvim-autopairs',
  -- event = { 'InsertEnter' },
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  config = function()
    -- import nvim-autopairs
    local autopairs = require 'nvim-autopairs'
    local cond = require 'nvim-autopairs.conds'

    -- configure autopairs
    autopairs.setup {
      check_ts = true,                      -- enable treesitter
      ts_config = {
        lua = { 'string' },                 -- don't add pairs in lua string treesitter nodes
        javascript = { 'template_string' }, -- don't add pairs in javascript template_string treesitter nodes
        java = false,                       -- don't check treesitter on java
      },
    }

    -- remove add ` char on filetype markdown
    local getRule = require('nvim-autopairs').get_rules
    getRule('`')[1].not_filetypes = { 'markdown' }

    -- local ts_conds = require 'nvim-autopairs.ts-conds'

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

    -- import nvim-cmp plugin (completions plugin)
    local cmp = require 'cmp'

    -- make autopairs and completion work together
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
