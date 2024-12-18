return {
  'hrsh7th/nvim-cmp',
  event = 'VimEnter',
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path',   -- source for file system paths
    -- snippet engine
    {
      'L3MON4D3/LuaSnip',
      -- follow latest release.
      version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = 'make install_jsregexp',
      dependencies = {
        'rafamadriz/friendly-snippets', -- useful snippets
        'honza/vim-snippets',
      },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_snipmate').lazy_load()
        require('luasnip.loaders.from_vscode').load { paths = { '~/.config/nvim/lua/bemu/snips' } } -- Load snippets from my-snippets folder
      end,
    },
    'saadparwaiz1/cmp_luasnip',            -- for autocompletion
    'onsails/lspkind.nvim',                -- vs-code like pictograms
    'hrsh7th/cmp-cmdline',                 -- cmdline completions
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help', -- nvim-cmp source for displaying function signatures with the current parameter emphasized
    'hrsh7th/cmp-nvim-lua',                -- nvim-cmp source for neovim Lua API.
    -- ripgrep source for nvim-cmp
    'lukas-reineke/cmp-rg',
    'lukas-reineke/cmp-under-comparator',
  },
  config = function()
    -- Set completeopt to have a better completion experience
    -- vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    -- vim.opt.completeopt = { 'menu,menuone,noinsert' }

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
    end

    local luasnip = require 'luasnip'
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local compare = require 'cmp.config.compare'

    local cmp_select = { behavior = cmp.SelectBehavior.Insert }

    cmp.setup {
      preselect = cmp.PreselectMode.None,
      window = {
        completion = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        },
      },
      snippet = {
        expand = function(args)
          -- For `luasnip` user.
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert,noselect',
        -- keyword_length = 1,
        -- keyword_pattern = '.*',
      },
      -- confirmation = { default_behavior = cmp.ConfirmBehavior.Replace },
      -- configure lspkind for vs-code like pictograms in completion menu
      -- formatting = {
      --   format = lspkind.cmp_format {
      --     maxwidth = 50,
      --     ellipsis_char = '...',
      --   },
      -- },
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<cr>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources {
        -- { name = "nvim_lua" },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        -- { name = 'nvim_lsp',               priority_weight = 1000 },
        -- { name = 'luasnip',                priority_weight = 750 },
        -- {
        --   name = 'buffer',
        --   -- max_item_count = 8,
        --   priority_weight = 500,
        --   -- option = {
        --   --     get_bufnrs = function()
        --   --         return vim.api.nvim_list_bufs()
        --   --     end,
        --   -- },
        -- },
        -- { name = 'path',                   priority_weight = 250 },
        -- {
        --     name = "rg",
        --     keyword_length = 3,
        --     max_item_count = 5,
        --     priority_weight = 60,
        --     option = { additional_arguments = "--smart-case --hidden" },
        -- },
        { name = 'nvim_lsp_signature_help' },
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          -- Default: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
          -- With sort_text added
          compare.exact,
          compare.score,
          compare.sort_text,
          compare.offset,
          compare.recently_used,
          compare.locality,
          compare.kind,
          compare.length,
          compare.order,
        },
      },

      -- sorting = {
      --     comparators = {
      --         cmp.config.compare.offset,
      --         cmp.config.compare.exact,
      --         cmp.config.compare.score,
      --         require("cmp-under-comparator").under,
      --         cmp.config.compare.kind,
      --         cmp.config.compare.sort_text,
      --         cmp.config.compare.length,
      --         cmp.config.compare.order,
      --     },
      -- },
      -- matching = {
      --     disallow_fuzzy_matching = true,
      --     disallow_fullfuzzy_matching = true,
      --     disallow_partial_fuzzy_matching = true,
      --     disallow_partial_matching = true,
      --     disallow_prefix_unmatching = false,
      -- },
      -- experimental = {
      --     -- I like the new menu better! Nice work hrsh7th
      --     native_menu = false,

      --     -- Let's play with this for a day or two
      --     ghost_text = false
      -- }
      -- experimental = {
      --   ghost_text = { hl_group = 'Comment' },
      --   horizontal_search = true,
      -- },
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,

  -- {
  -- 'saghen/blink.cmp',
  -- -- optional: provides snippets for the snippet source
  -- dependencies = {
  --   {
  --     'L3MON4D3/LuaSnip',
  --     -- follow latest release.
  --     version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  --     -- install jsregexp (optional!).
  --     build = 'make install_jsregexp',
  --     dependencies = {
  --       'rafamadriz/friendly-snippets', -- useful snippets
  --       'honza/vim-snippets',
  --     },
  --     config = function()
  --       require('luasnip.loaders.from_vscode').lazy_load()
  --       require('luasnip.loaders.from_snipmate').lazy_load()
  --       require('luasnip.loaders.from_vscode').load { paths = { '~/.config/nvim/lua/bemu/snips' } } -- Load snippets from my-snippets folder
  --     end,
  --   },
  -- },
  -- -- use a release tag to download pre-built binaries
  -- version = 'v0.*',
  -- -- version = 'main',
  -- -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- -- build = 'cargo build --release',
  -- -- If you use nix, you can build from source using latest nightly rust with:
  -- -- build = 'nix run .#build-plugin',
  --
  -- ---@module 'blink.cmp'
  -- ---@type blink.cmp.Config
  -- opts = {
  --   snippets = {
  --     expand = function(snippet)
  --       require('luasnip').lsp_expand(snippet)
  --     end,
  --     active = function(filter)
  --       if filter and filter.direction then
  --         return require('luasnip').jumpable(filter.direction)
  --       end
  --       return require('luasnip').in_snippet()
  --     end,
  --     jump = function(direction)
  --       require('luasnip').jump(direction)
  --     end,
  --   },
  --   -- 'default' for mappings similar to built-in completion
  --   -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  --   -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  --   -- see the "default configuration" section below for full documentation on how to define
  --   -- your own keymap.
  --
  --   -- When defining your own keymaps without a preset, no keybinds will be assigned automatically.
  --   --
  --   -- Available commands:
  --   --   show, hide, cancel, accept, select_and_accept, select_prev, select_next, show_documentation, hide_documentation,
  --   --   scroll_documentation_up, scroll_documentation_down, snippet_forward, snippet_backward, fallback
  --   --
  --   -- "default" keymap
  --   --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --   --   ['<C-e>'] = { 'hide' },
  --   --   ['<C-y>'] = { 'select_and_accept' },
  --   --
  --   --   ['<C-p>'] = { 'select_prev', 'fallback' },
  --   --   ['<C-n>'] = { 'select_next', 'fallback' },
  --   --
  --   --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  --   --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  --   --
  --   --   ['<Tab>'] = { 'snippet_forward', 'fallback' },
  --   --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --   --
  --   -- "super-tab" keymap
  --   --   you may want to set `completion.trigger.show_in_snippet = false`
  --   --   or use `completion.list.selection = "manual" | "auto_insert"`
  --   --
  --   --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --   --   ['<C-e>'] = { 'hide', 'fallback' },
  --   --
  --   --   ['<Tab>'] = {
  --   --     function(cmp)
  --   --       if cmp.snippet_active() then return cmp.accept()
  --   --       else return cmp.select_and_accept() end
  --   --     end,
  --   --     'snippet_forward',
  --   --     'fallback'
  --   --   },
  --   --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --   --
  --   --   ['<Up>'] = { 'select_prev', 'fallback' },
  --   --   ['<Down>'] = { 'select_next', 'fallback' },
  --   --   ['<C-p>'] = { 'select_prev', 'fallback' },
  --   --   ['<C-n>'] = { 'select_next', 'fallback' },
  --   --
  --   --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  --   --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  --   --
  --   -- "enter" keymap
  --   --   you may want to set `completion.list.selection = "manual" | "auto_insert"`
  --   --
  --   --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --   --   ['<C-e>'] = { 'hide', 'fallback' },
  --   --   ['<CR>'] = { 'accept', 'fallback' },
  --   --
  --   --   ['<Tab>'] = { 'snippet_forward', 'fallback' },
  --   --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --   --
  --   --   ['<Up>'] = { 'select_prev', 'fallback' },
  --   --   ['<Down>'] = { 'select_next', 'fallback' },
  --   --   ['<C-p>'] = { 'select_prev', 'fallback' },
  --   --   ['<C-n>'] = { 'select_next', 'fallback' },
  --   --
  --   --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  --   --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  --   keymap = { preset = 'enter' },
  --
  --   appearance = {
  --     -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --     -- Useful for when your theme doesn't support blink.cmp
  --     -- will be removed in a future release
  --     use_nvim_cmp_as_default = true,
  --     -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --     -- Adjusts spacing to ensure icons are aligned
  --     nerd_font_variant = 'mono',
  --   },
  --
  --   -- default list of enabled providers defined so that you can extend it
  --   -- elsewhere in your config, without redefining it, via `opts_extend`
  --   sources = {
  --     -- default = { 'lsp', 'path', 'snippets', 'buffer' },
  --     default = { 'lsp', 'path', 'luasnip', 'buffer' },
  --     -- optionally disable cmdline completions
  --     -- cmdline = {},
  --   },
  --
  --   -- experimental signature help support
  --   signature = { enabled = true },
  -- },
  -- -- allows extending the providers array elsewhere in your config
  -- -- without having to redefine it
  -- opts_extend = { 'sources.default' },
}
