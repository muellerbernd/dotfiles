return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.typstyle,
        null_ls.builtins.formatting.prettier.with {
          filetypes = { 'html', 'json', 'markdown' },
        },
        null_ls.builtins.formatting.yamlfmt.with {
          filetypes = { 'yaml' },
          extra_filetypes = { 'toml' },
        },

        -- null_ls.builtins.diagnostics.write_good,
        -- null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.fish_indent,
      },
    }

    vim.keymap.set('n', '<space>ff', function()
      vim.lsp.buf.format { async = true }
    end, { desc = '[f]ormat [f]ile' })
  end,
  --   { -- Autoformat
  --   'stevearc/conform.nvim',
  --   opts = {
  --     notify_on_error = false,
  --     format_on_save = {
  --       timeout_ms = 500,
  --       lsp_fallback = true,
  --     },
  --     formatters_by_ft = {
  --       lua = { 'stylua' },
  --       -- Conform can also run multiple formatters sequentially
  --       -- python = { "isort", "black" },
  --       --
  --       -- You can use a sub-list to tell conform to run *until* a formatter
  --       -- is found.
  --       -- javascript = { { "prettierd", "prettier" } },
  --     },
  --   },
  -- },
}
