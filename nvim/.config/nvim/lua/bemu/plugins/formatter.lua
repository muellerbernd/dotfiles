return {
  -- 'nvimtools/none-ls.nvim',
  -- config = function()
  --   local null_ls = require 'null-ls'
  --   null_ls.setup {
  --     sources = {
  --       null_ls.builtins.formatting.stylua,
  --       null_ls.builtins.formatting.prettier,
  --       null_ls.builtins.formatting.black,
  --       null_ls.builtins.formatting.isort,
  --       null_ls.builtins.formatting.shfmt,
  --       -- null_ls.builtins.formatting.typstyle,
  --       null_ls.builtins.formatting.prettier.with {
  --         filetypes = { 'html', 'json', 'markdown' },
  --       },
  --       null_ls.builtins.formatting.yamlfmt.with {
  --         filetypes = { 'yaml' },
  --         extra_filetypes = { 'toml' },
  --       },
  --
  --       -- null_ls.builtins.diagnostics.write_good,
  --       -- null_ls.builtins.code_actions.gitsigns,
  --       -- null_ls.builtins.formatting.fish_indent,
  --     },
  --   }
  --
  --   vim.keymap.set('n', '<space>ff', function()
  --     vim.lsp.buf.format { async = true }
  --   end, { desc = '[f]ormat [f]ile' })
  -- end,
  -- {
  'stevearc/conform.nvim',
  opts = {
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      -- bib = { 'bibtex-tidy' },
      html = { 'prettier' },
      css = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      json = { 'prettier' },
      just = { 'just' },
      -- python = { 'black', 'isort' },
      python = {
        -- To fix auto-fixable lint errors.
        'ruff_fix',
        -- To run the Ruff formatter.
        'ruff_format',
        -- To organize the imports.
        'ruff_organize_imports',
      },
      -- tex = { 'tex-fmt' },
      yaml = { 'yamlfmt' },
      toml = { 'yamlfmt' },
    },
    formatters = {
      -- ['tex-fmt'] = {
      --   prepend_args = { '--nowrap', '--tabsize', '4' },
      -- },
    },
    vim.keymap.set('n', '<space>ff', function()
      -- vim.lsp.buf.format { async = true }
      require('conform').format()
    end, { desc = '[f]ormat [f]ile' }),
  },
  -- }
}
