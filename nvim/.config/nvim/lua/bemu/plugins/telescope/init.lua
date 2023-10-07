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
  end,
}
