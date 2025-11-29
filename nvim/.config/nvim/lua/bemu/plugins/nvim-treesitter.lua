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
    },
    -- configure treesitter
    opts = { -- enable syntax highlighting
      highlight = {
        enable = true,
      },
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
        -- 'latex',
        -- 'bibtex',
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
        'typst',
        'just',
        'nim',
        'kdl',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<cr>',
          node_incremental = '<cr>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      indent = {
        enable = true,
        -- Treesitter unindents Yaml lists for some reason.
        disable = { 'yaml' },
      },
    },
    config = function(_, opts)
      local toggle_inc_selection_group = vim.api.nvim_create_augroup('bemu/toggle_inc_selection', { clear = true })
      vim.api.nvim_create_autocmd('CmdwinEnter', {
        desc = 'Disable incremental selection when entering the cmdline window',
        group = toggle_inc_selection_group,
        command = 'TSBufDisable incremental_selection',
      })
      vim.api.nvim_create_autocmd('CmdwinLeave', {
        desc = 'Enable incremental selection when leaving the cmdline window',
        group = toggle_inc_selection_group,
        command = 'TSBufEnable incremental_selection',
      })

      require('nvim-treesitter.configs').setup(opts)

      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = true,
    opts = {
      mode = 'cursor',
      max_lines = 3,
      -- Match the context lines to the source code.
      multiline_threshold = 1,
      -- Disable it when the window is too small.
      min_window_height = 20,
    },
    keys = {
      {
        '[c',
        function()
          -- Jump to previous change when in diffview.
          if vim.wo.diff then
            return '[c'
          else
            vim.schedule(function()
              require('treesitter-context').go_to_context()
            end)
            return '<Ignore>'
          end
        end,
        desc = 'Jump to upper context',
        expr = true,
      },
    },
  },
}
