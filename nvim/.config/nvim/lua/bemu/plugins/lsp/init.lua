return {
  {
    'neovim/nvim-lspconfig',
    -- event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- 'hrsh7th/cmp-nvim-lsp',
      'saghen/blink.cmp',
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
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
      _ = require 'bemu.plugins.lsp.handlers'
      local has_lsp, lspconfig = pcall(require, 'lspconfig')
      if not has_lsp then
        return
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      local capabilities = nil
      -- if pcall(require, 'cmp_nvim_lsp') then
      --   capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- end
      if pcall(require, 'blick.cmp') then
        capabilities = require('blick.cmp').get_lsp_capabilities()
      end
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local imap = function(keys, func, desc)
            vim.keymap.set('i', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]efe[r]ences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [i]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype definition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('gO', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[G]oto symb[O]ls')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      local servers = {
        -- 'pylsp', -- needs python-lsp-server
        'pyright', -- needs pyright
        -- "jedi-language-server",
        -- "ccls", -- needs ccls
        'clangd',        -- needs clangd
        'cmake',         -- needs cmake-language-server
        'gopls',         -- needs go
        'rust_analyzer', -- needs rust-analyzer
        'bashls',        -- needs bash-language-server
        'texlab',        -- needs texlab
        'html',          -- needs vscode-langservers-extracted
        'marksman',      -- needs marksman-bin
        'hls',           -- needs haskell-language-server
        -- 'ts_ls',      -- needs vscode-langservers-extracted
        'jsonls',        -- needs vscode-langservers-extracted
        'eslint',        -- needs vscode-langservers-extracted
        'tinymist',      -- needs tinymist
        -- 'nil_ls',        -- needs nil
        'nixd',
        'lemminx',
        'lua_ls',
      }
      -- local servers = { "pylsp", "clangd", "gopls", "rust_analyzer" }
      for _, lsp in ipairs(servers) do
        -- if lsp == "clangd" then
        --     nvim_lsp[lsp].setup({
        --         on_attach = my_on_attach,
        --         capabilities = capabilities,
        --         cmd = { "clangd", "--j=1", "--background-index" },
        --     })
        if lsp == 'clangd' then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            cmd = {
              'clangd',
              '--background-index',
              '--suggest-missing-includes',
              '--clang-tidy',
              '--header-insertion=iwyu',
            },
          }
        elseif lsp == 'ccls' then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            init_options = {
              compilationDatabaseDirectory = 'build',
              index = { threads = 1, comments = 0, trackDependency = 1 },
              clang = { excludeArgs = { '-frounding-math' } },
              cache = { retainInMemory = 0, directory = '/tmp/ccls-cache' },
            },
          }
        elseif lsp == 'rust_analyzer' then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            settings = {
              ['rust-analyzer'] = {
                assist = {
                  importGranularity = 'module',
                  importPrefix = 'self',
                },
                inlayHints = {
                  enable = true,
                  chainingHints = true,
                  maxLength = 25,
                  parameterHints = true,
                  typeHints = true,
                  hideNamedConstructorHints = false,
                  typeHintsSeparator = '‣',
                  typeHintsWithVariable = true,
                  chainingHintsSeparator = '‣',
                },
                cargo = {
                  loadOutDirsFromCheck = true,
                },
                procMacro = {
                  enable = true,
                },
              },
            },
          }
        elseif lsp == 'nil_ls' then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            settings = {
              ['nil'] = {
                testSetting = 42,
                formatting = {
                  command = { 'alejandra' },
                },
              },
            },
          }
        elseif lsp == 'nixd' then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            settings = {
              ['nixd'] = {
                nixpkgs = {
                  expr = 'import <nixpkgs> { }',
                },
                formatting = {
                  command = { 'alejandra' },
                  -- command = { 'nixfmt' },
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
          }
        elseif lsp == 'tinymist' then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            settings = {
              formatterMode = 'typstyle',
              exportPdf = 'disable',
              semanticTokens = 'disable',
            },
          }
        elseif lsp == 'pylsp' then
          lspconfig[lsp].setup {
            capabilities = capabilities,
            settings = {
              settings = {
                pylsp = {
                  plugins = {
                    pycodestyle = {
                      ignore = { 'W391' },
                      maxLineLength = 100,
                    },
                  },
                },
              },
            },
          }
        else
          lspconfig[lsp].setup {
            capabilities = capabilities,
          }
        end
      end
      -- lspconfig.lua_ls.setup {
      --   capabilities = capabilities,
      --   settings = {
      --     Lua = {
      --       runtime = { version = 'LuaJIT' },
      --       workspace = {
      --         checkThirdParty = false,
      --         -- Tells lua_ls where to find all the Lua files that you have loaded
      --         -- for your neovim configuration.
      --         library = {
      --           '${3rd}/luv/library',
      --           unpack(vim.api.nvim_get_runtime_file('', true)),
      --         },
      --         -- If lua_ls is really slow on your computer, you can try this instead:
      --         -- library = { vim.env.VIMRUNTIME },
      --       },
      --       completion = {
      --         callSnippet = 'Replace',
      --       },
      --       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      --       -- diagnostics = { disable = { 'missing-fields' } },
      --     },
      --   },
      -- }
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
      -- preview code with LSP code actions applied
      vim.keymap.set('n', 'gra', function()
        require('actions-preview').code_actions()
      end, { desc = 'LSP: [c]ode [a]ction preview' })
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
