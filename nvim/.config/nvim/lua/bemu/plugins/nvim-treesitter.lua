return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'lewis6991/spellsitter.nvim',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require 'nvim-treesitter.configs'

      -- configure treesitter
      treesitter.setup { -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          'bash',
          'cpp',
          'dockerfile',
          'html',
          'css',
          'json',
          'javascript',
          'latex',
          'bibtex',
          'lua',
          'python',
          'regex',
          'rust',
          'toml',
          'yaml',
          'go',
          'markdown_inline',
          'markdown',
          'vim',
          'dot',
          'haskell',
          'glimmer',
          'sql',
          'nix',
          'c',
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        -- context_commentstring = {
        --   enable = true,
        --   enable_autocmd = false,
        -- },
      }
      vim.g.skip_ts_context_commentstring_module = true
      -- vim.o.foldlevel = 5
      vim.o.foldmethod = 'expr'
      -- vim.o.foldmethod = 'indent'
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
      vim.opt.foldenable = false
    end,
  },
}
