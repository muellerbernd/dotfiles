return {

  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = {
      [[(\ (\                                            ]],
      [[( -.-)                                           ]],
      [[o_(")(")                                         ]],
      -- [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      -- [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      -- [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      -- [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }
    dashboard.section.buttons.val = {
      dashboard.button('f', '  Find file', "<cmd>lua require('bemu.plugins.telescope.funcs').search_all_files() <cr>"),
      dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
      -- dashboard.button("p", "  Vimwikis", "<cmd>lua require('bemu.telescope').list_vimwikis() <CR>"),
      dashboard.button('p', '  My-Wikis', "<cmd>lua require('bemu.plugins.telescope.funcs').list_mywikis() <CR>"),
      dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
      dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
      dashboard.button('c', '  Configuration', "<cmd>lua require('bemu.plugins.telescope.funcs').edit_neovim() <CR>"),
      dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
    }

    local function footer()
      -- NOTE: requires the fortune-mod package to work
      -- local handle = io.popen("fortune")
      -- local fortune = handle:read("*a")
      -- handle:close()
      -- return fortune
      return 'bernd@muellerbernd.de'
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = 'Type'
    dashboard.section.header.opts.hl = 'Include'
    dashboard.section.buttons.opts.hl = 'Keyword'

    dashboard.opts.opts.noautocmd = true
    -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
    alpha.setup(dashboard.opts)
  end,
}
