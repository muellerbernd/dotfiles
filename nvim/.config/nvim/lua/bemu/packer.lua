local fn = vim.fn
local ensure_packer = function()
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

packer.startup(function(use)
  -- local setup = function(repo, name)
  --     use({ repo, config = "require('" .. name .. "').setup({})" })
  -- end
  local local_use = function(v, opts)
    opts = vim.F.if_nil(opts, {})

    if vim.fn.isdirectory(vim.fn.expand('~/Desktop/GithubProjects/nvim-plugins/' .. v)) == 1 then
      opts[1] = '~/Desktop/GithubProjects/nvim-plugins/' .. v
    else
      print('~/Desktop/GithubProjects/nvim-plugins/' .. v .. ' does not exist')
      return
    end
    use(opts)
  end
  --[[helpers--]]
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- session management
  use 'tpope/vim-obsession'
  -- git in vim
  use 'tpope/vim-fugitive'
  -- autopairs
  use 'windwp/nvim-autopairs' -- Autopairs, integrates with both cmp and treesitter

  -- A high-performance color highlighter
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {}
    end,
  }
  -- Code formatter.
  use {
    'sbdchd/neoformat',
    -- cmd = "Neoformat",
  }
  -- commenter
  use {
    'numToStr/Comment.nvim',
  }
  -- Git signs.
  use {
    'lewis6991/gitsigns.nvim',
    -- event = "BufRead"
  }
  -- run commands asynchronous
  use {
    'skywind3000/asyncrun.vim',
  }
  use {
    'skywind3000/asynctasks.vim',
  }
  -- vim-header is a tool that helps us easily add author and license information to the scripts
  use {
    'alpertuna/vim-header',
  }
  -- key helper
  use {
    'folke/which-key.nvim',
  }
  -- nice startup screen
  use {
    'goolord/alpha-nvim',
  }
  -- write with sudo rights
  use 'lambdalisue/suda.vim'
  -- plugin to list todos in code
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {}
    end,
  }
  -- markdown-previewer
  use {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  }
  -- use {
  --     "iamcco/markdown-preview.nvim",
  --     run = "cd app && npm install",
  --     setup = function()
  --         vim.g.mkdp_filetypes = { "markdown" }
  --     end,
  --     ft = { "markdown" },
  -- }

  --[[lsp config --]]
  use {
    'neovim/nvim-lspconfig',
  }
  -- vscode-like pictograms to neovim built-in lsp
  use 'onsails/lspkind-nvim'
  -- Extensions to built-in LSP, for example, providing type inlay hints
  use 'nvim-lua/lsp_extensions.nvim'
  -- LSP signature.
  -- use({ "ray-x/lsp_signature.nvim" })
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  use 'jose-elias-alvarez/null-ls.nvim'
  -- Extra rust tools for writing applications in neovim using the native lsp. This plugin adds extra functionality over rust analyzer.
  -- use({
  --     "simrat39/rust-tools.nvim",
  -- config = function()
  --     require("rust-tools").setup({})
  -- end,
  -- })
  -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
  use {
    'j-hui/fidget.nvim',
  }
  -- This is a Neovim plugin/library for generating statusline components from the built-in LSP client.
  -- use("nvim-lua/lsp-status.nvim")
  use {
    'folke/neodev.nvim',

    config = function()
      require('neodev').setup {}
    end,
  }

  --[[ autocomplete tool --]]
  use {
    'hrsh7th/nvim-cmp',
  }
  -- cmp plugins
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- cmdline completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help' -- nvim-cmp source for displaying function signatures with the current parameter emphasized
  use 'hrsh7th/cmp-nvim-lua' -- nvim-cmp source for neovim Lua API.
  -- ripgrep source for nvim-cmp
  use 'lukas-reineke/cmp-rg'
  -- nvim-cmp source for treesitter nodes. Using all treesitter highlight nodes as completion candicates. LRU cache is used to improve performance.
  use 'ray-x/cmp-treesitter'
  -- A tiny function for nvim-cmp to better sort completion items that start with one or more underlines.
  use 'lukas-reineke/cmp-under-comparator'
  -- [[ snippets --]]
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  }
  -- Snippet engine
  -- snippets for some languages
  use 'rafamadriz/friendly-snippets'

  --[[TreeSitter ]]
  --
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  -- Show code context
  use 'nvim-treesitter/nvim-treesitter-context'
  -- A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  -- View treesitter information directly in Neovim!
  use 'nvim-treesitter/playground'
  -- Enable Neovim's builtin spellchecker for buffers with tree-sitter highlighting.
  use 'lewis6991/spellsitter.nvim'
  -- Refactor modules for nvim-treesitter
  -- use("nvim-treesitter/nvim-treesitter-refactor")
  -- Syntax aware text-objects, select, move, swap, and peek support.
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- A tiny Neovim plugin to deal with treesitter units. A unit is defined as a treesitter node including all its children. It allows you to quickly select, yank, delete or replace language-specific ranges.
  -- use("David-Kunz/treesitter-unit")
  use 'windwp/nvim-ts-autotag'

  --[[telescope ]]
  --
  use {
    'nvim-telescope/telescope.nvim',
    -- tag = "0.1.0",
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-media-files.nvim' }
  -- use("nvim-telescope/telescope-symbols.nvim")
  use 'nvim-telescope/telescope-packer.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-dap.nvim'
  -- It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker. Example would be lua vim.lsp.buf.code_action()
  use { 'nvim-telescope/telescope-ui-select.nvim' }

  --[[ Debugger --]]
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
    },
  }
  -- adapter for python
  use 'mfussenegger/nvim-dap-python'
  -- adapter for the Neovim lua language
  use 'jbyuki/one-small-step-for-vimkind'

  --[[     filebrowser ]]
  -- ranger
  -- use {
  -- "kevinhwang91/rnvimr",
  -- config = function()
  --     require("rnvimr").setup()
  -- end,
  -- }
  -- oil file explorer
  -- use {
  --     "stevearc/oil.nvim",
  --     config = function()
  --         require("oil").setup {
  --             -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
  --             default_file_explorer = false,
  --             -- Skip the confirmation popup for simple operations
  --             skip_confirm_for_simple_edits = true,
  --         }
  --     end,
  -- }
  -- use {
  --     "nvim-neo-tree/neo-tree.nvim",
  --     branch = "v2.x",
  --     requires = {
  --         "nvim-lua/plenary.nvim",
  --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --         "MunifTanjim/nui.nvim",
  --     },
  -- }

  --[[ appearance  --]]
  -- color theme
  use 'rktjmp/lush.nvim'
  require 'bemu.plugins.colorscheme'
  -- If you want to display icons, then use one of these plugins:
  use {
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    -- "kyazdani42/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup {}
    end,
  }
  -- Statusline.
  -- use "nvim-lualine/lualine.nvim"
  -- This plugin adds indentation guides to all lines (including empty lines).
  use {
    'lukas-reineke/indent-blankline.nvim',
    -- event = "BufRead",
  }
  -- Undo tree
  use {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
  }

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  -- use {
  --     "folke/noice.nvim",
  --     config = function()
  --         require("noice").setup {
  --             -- add any options here
  --         }
  --     end,
  --     requires = {
  --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --         "MunifTanjim/nui.nvim",
  --         -- OPTIONAL:
  --         --   `nvim-notify` is only needed, if you want to use the notification view.
  --         --   If not available, we use `mini` as the fallback
  --         "rcarriga/nvim-notify",
  --     },
  -- }

  --[[ custom plugins --]]
  -- Local plugins, use URL if not locally available
  -- list my vimwikis via telescope
  if vim.fn.isdirectory(vim.fn.expand '~/Desktop/GithubProjects/nvim-plugins/telescope-list-vimwiki.nvim') == 1 then
    local_use 'telescope-list-vimwiki.nvim'
  else
    use { 'muellerbernd/telescope-list-vimwiki.nvim' }
  end
  if vim.fn.isdirectory(vim.fn.expand '~/Desktop/GithubProjects/nvim-plugins/telescope-list-wikis.nvim') == 1 then
    local_use 'telescope-list-wikis.nvim'
  else
    use { 'muellerbernd/telescope-list-wikis.nvim' }
  end
  if vim.fn.isdirectory(vim.fn.expand '~/Desktop/GithubProjects/nvim-plugins/latex-previewer.nvim') == 1 then
    -- my own latex previewer plugin
    local_use 'latex-previewer.nvim'
  else
    use { 'muellerbernd/latex-previewer.nvim' }
  end

  -- telescope-asynctasks
  use 'muellerbernd/telescope-asynctasks.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if packer_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerSync',
  group = packer_group,
  pattern = 'packer.lua',
})
