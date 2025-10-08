return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
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
          -- preview code with LSP code actions applied
          vim.keymap.set('n', 'gra', function()
            require('actions-preview').code_actions()
          end, { desc = 'LSP: [c]ode [a]ction preview' })
        end,
      },
      { 'j-hui/fidget.nvim', opts = {} },
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      local lsp = require 'lspconfig'
      local on_lsp_attach = function(client, bufnr)
        local lsp_map = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { remap = true, buffer = bufnr, desc = desc, silent = true })
        end

        -- lsp_map('<D-.>', require('tiny-code-action').code_action, 'Code Action')
        -- lsp_map('<D-i>', function()
        --   if client.name == 'rust-analyzer' then
        --     vim.cmd.RustLsp { 'hover', 'actions' }
        --   else
        --     vim.lsp.buf.hover()
        --   end
        -- end, 'Hover Documentation')
        -- lsp_map('<D-r>', vim.lsp.buf.rename, 'Rename')
        -- lsp_map('gD', vim.lsp.buf.definition, 'Goto Declaration')
        -- lsp_map('gi', vim.lsp.buf.implementation, 'Goto Implementation')
        -- lsp_map('<D-g>', '<C-]>', '[G]oto [D]efinition')
        -- lsp_map('<D-u>', vim.lsp.buf.signature_help, 'Signature Documentation')
        --
        -- -- Various picker for lsp related stuff
        -- lsp_map('gr', Snacks.picker.lsp_references, '[G]oto [R]eferences')
        -- lsp_map('gi', Snacks.picker.lsp_implementations, '[G]oto [I]mplementations')
        -- lsp_map('gt', Snacks.picker.lsp_type_definitions, '[G]oto [T]ype Definitions')
        -- lsp_map('<D-l>', Snacks.picker.lsp_workspace_symbols, 'Search workspace symbols')
        -- lsp_map('<leader>ss', Snacks.picker.lsp_symbols, '[S]earch [S]ymbols')
        --
        -- lsp_map('<leader>lr', function()
        --   vim.cmd 'LspRestart'
        -- end, 'Lsp [R]eload')
        -- lsp_map('<leader>li', function()
        --   vim.cmd 'LspInfo'
        -- end, 'Lsp [R]eload')
        -- lsp_map('<leader>lh', function()
        --   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), { bufnr })
        -- end, 'Lsp toggle inlay [h]ints')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        lsp_map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        lsp_map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]efe[r]ences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        lsp_map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [i]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        lsp_map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype definition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        lsp_map('gO', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[G]oto symb[O]ls')

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        lsp_map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      end

      -- vim.diagnostic.config { virtual_lines = true }
      vim.diagnostic.config { virtual_text = true }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
      -- optimizes cpu usage source https://github.com/neovim/neovim/issues/23291
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰚌 ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = '󱧡 ',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
          },
          texthl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
          },
        },
      }

      local border = {
        { '╭', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╮', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '╯', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '╰', 'FloatBorder' },
        { '│', 'FloatBorder' },
      }

      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = border,
        }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = border,
        }),
      }

      -- Your existing floating preview override
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      vim.lsp.enable 'clangd'
      vim.lsp.config('clangd', {
        filetypes = { 'c', 'cpp', 'proto' },
        cmd = {
          'clangd',
          -- "--background-index",
          -- "--query-driver=/Users/dmtrkovalenko/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-gcc",
          '--offset-encoding=utf-16',
        },
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })

      vim.lsp.enable 'lua_ls'
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })

      vim.lsp.enable 'bashls'
      vim.lsp.config('bashls', {
        settings = { includeAllWorkspaceSymbols = true },
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })

      vim.lsp.enable 'marksman'
      vim.lsp.config('marksman', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })

      vim.lsp.enable 'taplo'
      vim.lsp.config('taplo', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })

      vim.lsp.enable 'pyright'
      vim.lsp.config('pyright', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })

      vim.lsp.enable 'nixd'
      vim.lsp.config('nixd', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
        settings = {
          ['nixd'] = {
            nixpkgs = {
              expr = 'import <nixpkgs> { }',
            },
            formatting = {
              -- command = { 'alejandra' },
              command = { 'nixfmt' },
            },
            -- options = {
            --   nixos = {
            --     expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.ammerapad.options',
            --   },
            --   home_manager = {
            --     expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."bernd@ammerapad".options',
            --   },
            -- },
          },
        },
      })
      vim.lsp.enable 'cmake'
      vim.lsp.config('cmake', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
      vim.lsp.enable 'rust_analyzer'
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
      vim.lsp.enable 'texlab'
      vim.lsp.config('texlab', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
      vim.lsp.enable 'html'
      vim.lsp.config('html', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
      vim.lsp.enable 'hls'
      vim.lsp.config('hls', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
      vim.lsp.enable 'jsonls'
      vim.lsp.config('jsonls', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
      vim.lsp.enable 'eslint'
      vim.lsp.config('eslint', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
      vim.lsp.enable 'tinymist'
      vim.lsp.config('tinymist', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
        settings = {
          formatterMode = 'typstyle',
          exportPdf = 'disable',
          semanticTokens = 'disable',
        },
      })
      vim.lsp.enable 'lemminx'
      vim.lsp.config('lemminx', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        handlers = handlers,
      })
    end,
  },
}
--         if lsp == 'clangd' then
--           vim.lsp.config(lsp, {
--             capabilities = capabilities,
--             on_attach = on_lsp_attach,
--             handlers = handlers,
--             cmd = {
--               'clangd',
--               '--background-index',
--               '--suggest-missing-includes',
--               '--clang-tidy',
--               '--header-insertion=iwyu',
--             },
--           })
--         elseif lsp == 'rust_analyzer' then
--           vim.lsp.config(lsp, {
--             capabilities = capabilities,
--             on_attach = on_lsp_attach,
--             handlers = handlers,
--             settings = {
--               ['rust-analyzer'] = {
--                 assist = {
--                   importGranularity = 'module',
--                   importPrefix = 'self',
--                 },
--                 inlayHints = {
--                   enable = true,
--                   chainingHints = true,
--                   maxLength = 25,
--                   parameterHints = true,
--                   typeHints = true,
--                   hideNamedConstructorHints = false,
--                   typeHintsSeparator = '‣',
--                   typeHintsWithVariable = true,
--                   chainingHintsSeparator = '‣',
--                 },
--                 cargo = {
--                   loadOutDirsFromCheck = true,
--                 },
--                 procMacro = {
--                   enable = true,
--                 },
--               },
--             },
--           })
