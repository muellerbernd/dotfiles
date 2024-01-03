return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufRead', 'BufNewFile' }, -- to disable, comment this out
  config = function()
    local conform = require 'conform'

    -- conform.formatters.tidy = {
    --   command = 'tidy',
    --   args = {
    --     '-quiet',
    --     '-xml',
    --     '--indent auto',
    --     string.format('--indent-spaces %i', vim.opt.shiftwidth:get()),
    --     '--vertical-space yes',
    --     '--tidy-mark no',
    --   },
    -- }
    conform.formatters.xmllint = {
      command = 'xmllint',
      args = {
        '--format',
        '--quiet',
        '-',
      },
    }

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        -- yaml = { 'prettier' },
        yaml = { 'yamlfmt' },
        xml = { 'xmllint' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        nix = { 'nixpkgs-fmt' },
        bash = { 'beautysh' },
        sh = { 'beautysh' },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      --   async = false,
      --   timeout_ms = 1000,
      -- },
    }

    vim.keymap.set({ 'n', 'v' }, '<F3>', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = 'Format file or range (in visual mode)' })
  end,

  -- 'sbdchd/neoformat',
  -- lazy = true,
  -- event = { 'BufRead', 'BufNewFile' }, -- to disable, comment this out
  -- config = function()
  --   -- Enable alignment
  --   vim.g.neoformat_basic_format_align = 1
  --
  --   -- Enable tab to spaces conversion
  --   vim.g.neoformat_basic_format_retab = 1
  --
  --   -- Enable trimmming of trailing whitespace
  --   vim.g.neoformat_basic_format_trim = 1
  --
  --   -- run all formatters
  --   vim.g.neoformat_run_all_formatters = 0
  --   -- Have Neoformat only msg when there is an error
  --   -- vim.g.neoformat_only_msg_on_error = 1
  --   --
  --   vim.g.neoformat_enabled_python = { 'isort', 'black' }
  --   vim.g.neoformat_enabled_rust = { 'rustfmt' }
  --   vim.g.neoformat_enabled_lua = { 'stylua' }
  --   vim.g.neoformat_enabled_yaml = { 'prettier' }
  --   vim.g.neoformat_enabled_json = { 'prettier' }
  --   vim.g.neoformat_enabled_css = { 'prettier' }
  --   vim.g.neoformat_enabled_html = { 'prettier' }
  --   -- vim.g.neoformat_enabled_handlebars = {}
  --   vim.g.neoformat_enabled_xml = { 'tidy' }
  --   vim.g.neoformat_enabled_bash = { 'topiary' }
  --   vim.g.neoformat_enabled_sh = { 'topiary' }
  --   vim.g.neoformat_enabled_haskell = { 'ormolu' }
  --   vim.g.neoformat_enabled_markdown = { 'prettier' }
  --   vim.g.neoformat_enabled_nix = { 'nixfmt' }
  --
  --   vim.keymap.set({ 'n', 'v' }, '<F3>', '<cmd>Neoformat<cr>', { desc = 'Format file or range (in visual mode)' })
  -- end,
}
