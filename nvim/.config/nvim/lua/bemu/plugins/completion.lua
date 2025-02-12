return {
  'saghen/blink.cmp',
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
  -- version = 'main',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = 'cargo build --release',
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

      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- optionally disable cmdline completions
      cmdline = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == '/' or type == '?' then
          return { 'buffer' }
        end
        -- Commands
        if type == ':' then
          return { 'cmdline' }
        end
        return {}
      end,
    },
    snippets = { preset = 'luasnip' },

    -- experimental signature help support
    signature = { enabled = true },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    completion = {
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = false } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        update_delay_ms = 50,
        treesitter_highlighting = true,
        window = { border = 'rounded' },
      },
      list = { selection = { preselect = false, auto_insert = false } },
      menu = {
        auto_show = true,
        border = 'rounded',
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
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
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.default' },
}
