return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets', -- useful snippets
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
        require('luasnip.loaders.from_vscode').load { paths = { '~/.config/nvim/snippets/' } } -- Load snippets from my-snippets folder
      end,
    },
  },
  -- use a release tag to download pre-built binaries
  -- version = 'v0.*',
  -- version = 'v0.13.0',
  version = 'v1.*',
  -- version = 'main',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    --   https://cmp.saghen.dev/configuration/keymap.html#enter
    keymap = {
      preset = 'none',

      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' },

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },
    completion = {
      list = {
        -- Insert items while navigating the completion list.
        selection = { preselect = false, auto_insert = true },
        max_items = 10,
      },
      menu = {
        border = 'rounded',
        draw = {
          columns = {
            { 'kind_icon', 'label', gap = 1 },
            { 'kind' },
          },
          components = {
            kind_icon = {
              text = function(item)
                local kind = require('lspkind').symbol_map[item.kind] or ''
                return kind .. ' '
              end,
              highlight = 'CmpItemKind',
            },
            label = {
              text = function(item)
                return item.label
              end,
              highlight = 'CmpItemAbbr',
            },
            kind = {
              text = function(item)
                return item.kind
              end,
              highlight = 'CmpItemKind',
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        update_delay_ms = 50,
        treesitter_highlighting = true,
        window = { border = 'rounded' },
      },
    },
    snippets = { preset = 'luasnip' },
    -- experimental signature help support
    signature = { enabled = true },
    -- Disable command line completion:
    cmdline = {
      enabled = true,
      keymap = { preset = 'inherit' },
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == '/' or type == '?' then
          return { 'buffer' }
        end
        -- Commands
        if type == ':' or type == '@' then
          return { 'cmdline' }
        end
        return {}
      end,
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = {},
        },
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = true,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = true,
          },
        },
        -- Whether to automatically show the window when new completion items are available
        menu = { auto_show = true },
        -- Displays a preview of the selected item on the current line
        ghost_text = { enabled = true },
      },
    },
    sources = {

      -- Disable some sources in comments and strings.
      default = function()
        local sources = { 'lsp', 'snippets', 'buffer' }
        local ok, node = pcall(vim.treesitter.get_node)

        if ok and node then
          if not vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            table.insert(sources, 'path')
          end
          if node:type() ~= 'string' then
            table.insert(sources, 'snippets')
          end
        end

        return sources
      end,
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
  },
}
