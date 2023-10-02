-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- local setup = function(repo, name)
  --     ({ repo, config = "require('" .. name .. "').setup({})" })
  -- end
  -- --[[helpers--]]
  -- session management
  'tpope/vim-obsession',
  -- git in vim
  'tpope/vim-fugitive',
  -- autopairs
  {
    'windwp/nvim-autopairs', -- Autopairs, integrates with both cmp and treesitter
    config = function()
      require('nvim-autopairs').setup {
        -- map_c_h = true, -- Map the <C-h> key to delete a pair
        -- map_c_w = true, -- map <c-w> to delete a pair if possible
      }
    end,
  },
  -- nvim-surround
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- A high-performance color highlighter
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {}
    end,
  },
  -- Code formatter.
  {
    'sbdchd/neoformat',
    -- cmd = "Neoformat",
  },
  -- commenter
  {
    'numToStr/Comment.nvim',
  },
  -- Git signs.
  {
    'lewis6991/gitsigns.nvim',
    -- event = "BufRead"
  },
  -- run commands asynchronous
  {
    'skywind3000/asyncrun.vim',
  },
  {
    'skywind3000/asynctasks.vim',
  },
  -- vim-header is a tool that helps us easily add author and license information to the scripts
  {
    'alpertuna/vim-header',
  },
  -- key helper
  {
    'folke/which-key.nvim',
  },
  -- nice startup screen
  {
    'goolord/alpha-nvim',
  },
  -- write with sudo rights
  'lambdalisue/suda.vim',
  -- plugin to list todos in code
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {}
    end,
  },
  -- markdown-previewer
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },

  --[[lsp config --]]
  {
    'neovim/nvim-lspconfig',
  },
  -- vscode-like pictograms to neovim built-in lsp
  'onsails/lspkind-nvim',
  -- Extensions to built-in LSP, for example, providing type inlay hints
  'nvim-lua/lsp_extensions.nvim',
  -- LSP signature.
  -- ({ "ray-x/lsp_signature.nvim" })
  --  Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  -- "jose-elias-alvarez/null-ls.nvim"
  -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
  {
    'j-hui/fidget.nvim',
  },
  -- This is a Neovim plugin/library for generating statusline components from the built-in LSP client.
  -- ("nvim-lua/lsp-status.nvim")
  {
    'folke/neodev.nvim',

    config = function()
      require('neodev').setup {}
    end,
  },
  -- A neovim plugin that preview code with LSP code actions applied.
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      require('actions-preview').setup {
        telescope = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = 'top',
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      }
    end,
  },

  --[[ autocomplete tool --]]
  {
    'hrsh7th/nvim-cmp',
  },
  -- cmp plugins
  'hrsh7th/cmp-buffer', -- buffer completions
  'hrsh7th/cmp-path', -- path completions
  'hrsh7th/cmp-cmdline', -- cmdline completions
  'saadparwaiz1/cmp_luasnip', -- snippet completions
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help', -- nvim-cmp source for displaying function signatures with the current parameter emphasized
  'hrsh7th/cmp-nvim-lua', -- nvim-cmp source for neovim Lua API.
  -- ripgrep source for nvim-cmp
  'lukas-reineke/cmp-rg',
  -- nvim-cmp source for treesitter nodes. Using all treesitter highlight nodes as completion candicates. LRU cache is d to improve performance.
  'ray-x/cmp-treesitter',
  -- A tiny function for nvim-cmp to better sort completion items that start with one or more underlines.
  'lukas-reineke/cmp-under-comparator',
  -- [[ snippets --]]
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  -- Snippet engine
  -- snippets for some languages
  'rafamadriz/friendly-snippets',

  --[[TreeSitter ]]
  --
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  -- Show code context
  'nvim-treesitter/nvim-treesitter-context',
  -- A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.
  'JoosepAlviste/nvim-ts-context-commentstring',
  -- View treesitter information directly in Neovim!
  'nvim-treesitter/playground',
  -- Enable Neovim's builtin spellchecker for buffers with tree-sitter highlighting.
  'lewis6991/spellsitter.nvim',
  -- Refactor modules for nvim-treesitter
  -- ("nvim-treesitter/nvim-treesitter-refactor")
  -- Syntax aware text-objects, select, move, swap, and peek support.
  'nvim-treesitter/nvim-treesitter-textobjects',
  -- A tiny Neovim plugin to deal with treesitter units. A unit is defined as a treesitter node including all its children. It allows you to quickly select, yank, delete or replace language-specific ranges.
  -- ("David-Kunz/treesitter-unit")
  'windwp/nvim-ts-autotag',

  --[[telescope ]]
  --
  {
    'nvim-telescope/telescope.nvim',
    -- tag = "0.1.0",
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope-media-files.nvim' },
  'nvim-telescope/telescope-packer.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  'nvim-telescope/telescope-dap.nvim',
  -- It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker. Example would be lua vim.lsp.buf.code_action()
  { 'nvim-telescope/telescope-ui-select.nvim' },

  --[[ Debugger --]]
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
    },
  },
  -- adapter for python
  'mfussenegger/nvim-dap-python',
  -- adapter for the Neovim lua language
  'jbyuki/one-small-step-for-vimkind',

  --[[ appearance  --]]
  -- color theme
  'rktjmp/lush.nvim',
  -- If you want to display icons, then  one of these plugins:
  {
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    -- "kyazdani42/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup {}
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
      vim.notify.setup {
        -- background_colour = 'CursorColumn',
        background_colour = '#000000',
      }
    end,
  },
  -- {
  --     "folke/noice.nvim",
  --     event = "VeryLazy",
  --     opts = {
  --         -- add any options here
  --     },
  --     dependencies = {
  --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --         "MunifTanjim/nui.nvim",
  --         -- OPTIONAL:
  --         --   `nvim-notify` is only needed, if you want to use the notification view.
  --         --   If not available, we use `mini` as the fallback
  --         "rcarriga/nvim-notify",
  --     },
  -- },
  -- Statusline.
  --  "nvim-lualine/lualine.nvim"
  -- This plugin adds indentation guides to all lines (including empty lines).
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    main = 'ibl',
  },

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- symbol = "▏",
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Undo tree
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
  },

  -- [[ custom plugins ]]
  -- Local plugins,  URL if not locally available
  -- list my vimwikis via telescope
  { 'muellerbernd/telescope-list-vimwiki.nvim' },
  { 'muellerbernd/telescope-list-wikis.nvim' },
  { 'muellerbernd/latex-previewer.nvim' },

  -- telescope-asynctasks
  'muellerbernd/telescope-asynctasks.nvim',
}, {})
require 'bemu.plugins.colorscheme'
-- Automatically source and re-compile lazy whenever you save this init.lua
-- local lazy_group = vim.api.nvim_create_augroup("Lazy", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     command = "source <afile> | Lazy update",
--     group = lazy_group,
--     pattern = "lazy.lua",
-- })
