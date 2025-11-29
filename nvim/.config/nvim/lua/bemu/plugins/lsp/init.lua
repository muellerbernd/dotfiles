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
      -- ╭──────────────────────────────────────────────────────────╮
      -- │ ⬇️ disable default keybinds                              │
      -- ╰──────────────────────────────────────────────────────────╯
      for _, bind in ipairs { 'grn', 'gra', 'gri', 'grr', 'grt' } do
        pcall(vim.keymap.del, 'n', bind)
      end

      local on_lsp_attach = function(client, bufnr)
        local lsp_map = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { remap = true, buffer = bufnr, desc = desc, silent = true })
        end

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

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ ⬇️ setup vim.diagnostic.Config                           │
      -- ╰──────────────────────────────────────────────────────────╯

      local diagnostic_opts = {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
          },
        },
        virtual_text = {
          virt_text_pos = 'eol_right_align',
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = 'rounded',
          header = '',
        },
      }

      vim.diagnostic.config(diagnostic_opts)

      -- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
      -- -- optimizes cpu usage source https://github.com/neovim/neovim/issues/23291
      -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      -- ╭──────────────────────────────────────────────────────────╮
      -- │ ⬇️ server specific capabilities                          │
      -- ╰──────────────────────────────────────────────────────────╯

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local has_blink = require('lazy.core.config').plugins['blink.cmp'] ~= nil
      if has_blink then
        capabilities = vim.tbl_deep_extend('force', capabilities, {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        })
      end

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
      })

      vim.lsp.enable 'bashls'
      vim.lsp.config('bashls', {
        settings = { includeAllWorkspaceSymbols = true },
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })

      vim.lsp.enable 'marksman'
      vim.lsp.config('marksman', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })

      vim.lsp.enable 'taplo'
      vim.lsp.config('taplo', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })

      -- vim.lsp.enable 'pyright'
      -- vim.lsp.config('pyright', {
      --   capabilities = capabilities,
      --   on_attach = on_lsp_attach,
      -- })
      -- vim.lsp.enable 'ruff'
      -- vim.lsp.config('ruff', {
      --   capabilities = capabilities,
      --   on_attach = on_lsp_attach,
      --   init_options = {
      --     settings = {
      --       -- Ruff language server settings go here
      --     },
      --   },
      -- })
      vim.lsp.config('pyright', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
        settings = {
          pyright = {
            -- Using Ruff's import organizer.
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting.
              ignore = { '*' },
            },
          },
        },
      })

      vim.lsp.config('ruff', {
        settings = {
          organizeImports = true,
        },
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })

      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if client == nil then
      --       return
      --     end
      --     if client.name == 'ruff' then
      --       -- Disable hover in favor of Pyright.
      --       client.server_capabilities.hoverProvider = false
      --     end
      --   end,
      --   desc = 'LSP: Disable hover capability from Ruff',
      -- })

      vim.lsp.enable { 'pyright', 'ruff' }

      vim.lsp.enable 'nixd'
      vim.lsp.config('nixd', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
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
      })
      vim.lsp.enable 'rust_analyzer'
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      vim.lsp.enable 'texlab'
      vim.lsp.config('texlab', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      vim.lsp.enable 'html'
      vim.lsp.config('html', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      vim.lsp.enable 'hls'
      vim.lsp.config('hls', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      vim.lsp.enable 'jsonls'
      vim.lsp.config('jsonls', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      vim.lsp.enable 'eslint'
      vim.lsp.config('eslint', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      vim.lsp.enable 'tinymist'
      vim.lsp.config('tinymist', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
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
      })
      vim.lsp.config('*', {
        capabilities = capabilities,
        on_attach = on_lsp_attach,
      })
      -- vim.lsp.enable 'ltex_plus'
      -- vim.lsp.config('ltex_plus', {
      --   capabilities = capabilities,
      --   on_attach = on_lsp_attach,
      --   settings = {
      --     ltex = {
      --       language = 'de-DE',
      --       filetypes = {
      --         'bib',
      --         'context',
      --         'gitcommit',
      --         'html',
      --         'markdown',
      --         'org',
      --         'pandoc',
      --         'plaintex',
      --         'quarto',
      --         'mail',
      --         'mdx',
      --         'rmd',
      --         'rnoweb',
      --         'rst',
      --         'tex',
      --         'text',
      --         'typst',
      --         'xhtml',
      --       },
      --       additionalRules = {
      --         enablePickyRules = true,
      --         motherTongue = 'de-DE',
      --       },
      --     },
      --   },
      -- })
    end,
  },
}
