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
      'JoosepAlviste/nvim-ts-context-commentstring',
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
      vim.o.foldmethod = 'expr'
      -- vim.o.foldmethod = 'indent'
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
      vim.opt.foldenable = false
    end,
  },
  { 'luckasRanarison/tree-sitter-hypr', ft = 'hypr' },
}
