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
        null_ls.builtins.formatting.prettier.with {
          filetypes = { 'html', 'json', 'markdown' },
        },
        null_ls.builtins.formatting.yamlfmt.with {
          filetypes = { 'yaml' },
          extra_filetypes = { 'toml' },
        },
        -- null_ls.builtins.formatting.xmllint.with {
        --   filetypes = { 'xml' },
        -- },

        -- null_ls.builtins.diagnostics.write_good,
        -- null_ls.builtins.code_actions.gitsigns,
      },
    }

    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, { desc = '[f]ormat buffer' })
  end,
}
