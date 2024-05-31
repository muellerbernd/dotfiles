return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = {
      'TSBufDisable',
      'TSBufEnable',
      'TSBufToggle',
      'TSDisable',
      'TSEnable',
      'TSToggle',
      'TSInstall',
      'TSInstallInfo',
      'TSInstallSync',
      'TSModuleInfo',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
    },
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'lewis6991/spellsitter.nvim',
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    -- configure treesitter
    opts = { -- enable syntax highlighting
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
        'c',
        'cpp',
        'dockerfile',
        'html',
        'css',
        'json',
        'javascript',
        'latex',
        'bibtex',
        'lua',
        'luadoc',
        'python',
        'regex',
        'rust',
        'toml',
        'yaml',
        'go',
        'markdown_inline',
        'markdown',
        'vim',
        'vimdoc',
        'rasi',
        'dot',
        'haskell',
        'glimmer',
        'sql',
        'nix',
        -- 'hypr',
        'hyprlang',
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
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true,
      --     kahead = true,
      --     selection_modes = {
      --       ['@parameter.outer'] = 'v', -- charwise
      --       ['@function.outer'] = 'V',  -- linewise
      --       ['@class.outer'] = '<c-v>', -- blockwise
      --     },
      --     keymaps = {
      --
      --       ['aa'] = { query = '@parameter.outer', desc = '🌲select around function' },
      --       ['ia'] = { query = '@parameter.inner', desc = '🌲select inside function' },
      --
      --       ['af'] = { query = '@function.outer', desc = '🌲select around function' },
      --       ['if'] = { query = '@function.inner', desc = '🌲select inside function' },
      --       ['ac'] = { query = '@class.outer', desc = '🌲select around class' },
      --       ['ic'] = { query = '@class.inner', desc = '🌲select inside class' },
      --       ['al'] = { query = '@loop.outer', desc = '🌲select around loop' },
      --       ['il'] = { query = '@loop.inner', desc = '🌲select inside loop' },
      --       ['ab'] = { query = '@block.outer', desc = '🌲select around block' },
      --       ['ib'] = { query = '@block.inner', desc = '🌲select inside block' },
      --     },
      --   },
      --   move = {
      --     enable = true,
      --     set_jumps = true,
      --     goto_next_start = {},
      --     goto_previous_start = {},
      --   },
      --   lsp_interop = {
      --     enable = true,
      --     border = 'rounded',
      --     peek_definition_code = {},
      --   },
      -- },
    },
    config = function(_, opts)
      -- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      --
      -- parser_config.hypr = {
      --   install_info = {
      --     url = 'https://github.com/luckasranarison/tree-sitter-hypr',
      --     files = { 'src/parser.c' },
      --     branch = 'master',
      --   },
      --   filetype = 'hypr',
      -- }

      require('nvim-treesitter.configs').setup(opts)

      vim.g.skip_ts_context_commentstring_module = true
      -- vim.o.foldlevel = 5
      -- vim.o.foldmethod = 'expr'
      -- -- vim.o.foldmethod = 'indent'
      -- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
      -- vim.opt.foldenable = false
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    opts = { mode = 'cursor', max_lines = 3 },
  },
}
