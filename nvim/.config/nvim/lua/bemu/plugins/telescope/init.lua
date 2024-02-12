return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-file-browser.nvim',
    -- It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker. Example would be lua vim.lsp.buf.code_action()
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local actions = require 'telescope.actions'
    local sorters = require 'telescope.sorters'
    local themes = require 'telescope.themes'
    local previewers = require 'telescope.previewers'
    -- local trouble = require("trouble.providers.telescope")
    require('telescope').setup {
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '--no-ignore',
          '--follow',
        },
        prompt_prefix = '> ',
        selection_caret = '> ',
        entry_prefix = '  ',
        -- initial_mode = "insert",
        initial_mode = 'normal',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          height = 0.90,
          prompt_position = 'top',
          preview_height = 15,
        },
        -- winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        -- file_previewer = previewers.vim_buffer_cat.new,
        -- grep_previewer = previewers.vim_buffer_vimgrep.new,
        -- qflist_previewer = previewers.vim_buffer_qflist.new,
        dynamic_preview_title = true,
        -- path_display = {},
        path_display = { 'truncate' },
        -- path_display = { "smart" },
        mappings = {
          i = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<ScrollWheelUp>'] = actions.preview_scrolling_up,
            ['<ScrollWheelDown>'] = actions.preview_scrolling_down,
          },
          n = {
            q = actions.close,
            ['<ScrollWheelUp>'] = actions.preview_scrolling_up,
            ['<ScrollWheelDown>'] = actions.preview_scrolling_down,
          },
        },
        -- Developer configurations: Not meant for general override
        -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
      pickers = {
        grep_string = {
          -- only sort top 50 entries
          temp__scrolling_limit = 50,
        },
        find_files = {
          find_command = {
            'fd',
            '--type',
            'f',
            '--strip-cwd-prefix',
            '-E',
            '*cache*',
            '--follow',
          },
          cwd = vim.fn.expand '%:p:h',
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        file_browser = {
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          cwd_to_path = true,
          grouped = true,
          select_buffer = true,
          respect_gitignore = false,
          hidden = false,
          follow_symlinks = true,
          show_symlink = true,
        },
        -- ['ui-select'] = {
        --   require('telescope.themes').get_dropdown {
        --     -- even more opts
        --   },
        --
        --   -- pseudo code / specification for writing custom displays, like the one
        --   -- for "codeactions"
        --   -- specific_opts = {
        --   --   [kind] = {
        --   --     make_indexed = function(items) -> indexed_items, width,
        --   --     make_displayer = function(widths) -> displayer
        --   --     make_display = function(displayer) -> function(e)
        --   --     make_ordinal = function(e) -> string
        --   --   },
        --   --   -- for example to disable the custom builtin "codeactions" display
        --   --      do the following
        --   --   codeactions = false,
        --   -- }
        -- },
      },
    }
    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    -- Load the fzy native extension at the start.
    pcall(require('telescope').load_extension, 'fzy_native')
    -- To get telescope-file-browser loaded
    pcall(require('telescope').load_extension, 'file_browser')
    -- To get ui-select loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require('telescope').load_extension 'ui-select'

    vim.keymap.set(
      'n',
      '<leader>ff',
      "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h'), find_command={'rg','--ignore','--hidden','--files'}, prompt_prefix='🔍' }) <cr>",
      { desc = '[f]ind [f]iles' }
    )
    vim.keymap.set('n', '<leader>fg', "<cmd>lua require('bemu.plugins.telescope.funcs').live_grep()<cr>", { desc = '[f]ind with [g]rep' })
    vim.keymap.set('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { desc = '[f]ind [b]uffers' })
    vim.keymap.set('n', '<leader>fS', "<cmd>lua require('telescope.builtin').spell_suggest()<cr>", { desc = '[f]ix [S]pell' })
    vim.keymap.set(
      'n',
      '<leader>fG',
      "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
      { desc = '[f]ind with [G]rep in current buffer' }
    )
    vim.keymap.set('n', '<leader>fh', "<cmd>lua require('bemu.plugins.telescope.funcs').help_tags()<cr>", { desc = '[f]ind in [h]elp' })
    vim.keymap.set('n', '<leader>fl', "<cmd>lua require('telescope.builtin').resume()<cr>", { desc = '[f]ind in [l]ast picker' })
    vim.keymap.set('n', '<leader>fT', "<cmd>lua require('telescope.builtin').treesitter()<cr>", { desc = '[f]ind via [T]reesitter' })
    vim.keymap.set('n', '<leader>fR', "<cmd>lua require('telescope.builtin').registers()<CR>", { desc = '[f]ind in [r]egisters' })
    vim.keymap.set('n', '<leader>en', "<cmd>lua require('bemu.plugins.telescope.funcs').edit_neovim()<cr>", { desc = '[e]dit [n]eovim config' })
    vim.keymap.set('n', '<leader>el', "<cmd>lua require('bemu.plugins.telescope.funcs').local_plugins()<cr>", { desc = 'list [l]ocal [p]lugins' })
    vim.keymap.set('n', '<leader>qr', "<cmd>lua require('bemu.plugins.telescope.funcs').reload()<cr>", { desc = '[q]uick [r]eload plugins' })
    vim.keymap.set('n', '<leader>fr', "<cmd>lua require('bemu.plugins.telescope.funcs').file_browser()<cr>", { desc = '[f]ile b[r]owser' })
    -- telescope tasks
    vim.keymap.set('n', '<leader>ft', "<cmd>lua require('telescope').extensions.asynctasks.all()<CR>", { desc = '[f]ind in configured async[t]asks' })
    -- telescope wiki
    vim.keymap.set('n', '<leader>fw', "<cmd>lua require('bemu.plugins.telescope.funcs').list_mywikis()<cr>", { desc = '[f]ind configured [w]ikis' })

    vim.keymap.set('n', '<F8>', function()
      require('bemu.plugins.telescope.funcs').current_buffer_tags()
    end, { desc = 'show current buffer tags' })

    vim.keymap.set('n', '<leader>fs', function()
      require('telescope.builtin').lsp_document_symbols()
    end, { desc = '[f]ind via lsp [s]ymbols' })

    vim.keymap.set('n', '<leader>fo', function()
      require('bemu.plugins.telescope.funcs').oldfiles()
    end, { desc = 'show oldfiles' })
  end,
}
