_ = require 'bemu.lsp.handlers'
local has_lsp, lspconfig = pcall(require, 'lspconfig')
local has_lsp_sig, lspsig = pcall(require, 'lsp_signature')
if not has_lsp then
  return
end

-- local lspconfig_util = require("lspconfig.util")
-- local telescope_mapper = require("bemu.telescope.mappings")
-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()
-- after the language server attaches to the current buffer
local function config(_config)
  return vim.tbl_deep_extend('force', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    -- Set default client capabilities plus window/workDoneProgress
    -- capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities),
    on_attach = function(client, bufnr)
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end
      local opts = { noremap = true, silent = true }
      buf_set_keymap('n', 'gr', "<cmd>lua require('bemu.telescope.funcs').lsp_references()<cr>", { desc = '[g]oto [r]eferences' })
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { desc = '[g]oto [D]eclaration' })
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { desc = '[g]oto [d]efinition' })
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'show information' })
      -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      buf_set_keymap('n', 'gI', "<cmd>lua require('bemu.telescope.funcs').lsp_implementations()<cr>", { desc = '[g]oto [I]mplementation' })
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'signature_help' })
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { desc = '[w]orkspace [a]dd' })
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { desc = '[w]orkspace [r]emove' })
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { desc = 'list [w]orkspace [f]olders' })
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'show type [D]efinition' })
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'lsp [r]e[n]ame' })
      buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'show [c]ode [a]ctions' })
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float() <CR>', { desc = 'list [e]rror diagnostics' })
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'goto [prev [d]iagnostic' })
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'goto ]next [d]iagnostic' })
      buf_set_keymap('n', '<space>q', "<cmd>lua require('bemu.telescope.funcs').lsp_set_loclist()<cr>", { desc = 'lsp_set_loclist' })
      buf_set_keymap('n', '<space>wd', "<cmd>lua require('bemu.telescope.funcs').lsp_document_symbols()<cr>", { desc = 'list [w]orkspace [d]ocument symbols' })
      buf_set_keymap('n', '<space>ww', "<cmd>lua require('bemu.telescope.funcs').lsp_workspace_symbols()<cr>", { desc = 'list workspace symbols' })
      buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async=true }<CR>', { desc = '[f]ormat buffer' })
      -- lsp signature
      if has_lsp_sig then
        -- lspsig.on_attach()
        lspsig.on_attach({
          bind = true, -- This is mandatory, otherwise border config won't get registered.
          handler_opts = {
            border = 'rounded',
          },
        }, bufnr)
      end
      --lsp_status.on_attach
    end,
    flags = {
      debounce_text_changes = 150,
    },
  }, _config or {})
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  -- "pylsp", -- needs python-lsp-server
  'pyright', -- needs pyright
  -- "ccls", -- needs ccls
  'clangd', -- needs clangd
  'cmake', -- needs cmake-language-server
  'gopls', -- needs go
  'rust_analyzer', -- needs rust-analyzer
  'bashls', -- needs bash-language-server
  'texlab', -- needs texlab
  'html', -- needs vscode-langservers-extracted
  'marksman', -- needs marksman-bin
  'hls', -- needs haskell-language-server
  'rnix', -- needs rnix-lsp
  'tsserver', -- needs vscode-langservers-extracted
  'jsonls', -- needs vscode-langservers-extracted
  'eslint', -- needs vscode-langservers-extracted
  'typst_lsp', -- needs typst-lsp
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
    lspconfig[lsp].setup(config {
      cmd = {
        'clangd',
        '--background-index',
        '--suggest-missing-includes',
        '--clang-tidy',
        '--header-insertion=iwyu',
      },
    })
  elseif lsp == 'ccls' then
    lspconfig[lsp].setup(config {
      init_options = {
        compilationDatabaseDirectory = 'build',
        index = { threads = 1, comments = 0, trackDependency = 1 },
        clang = { excludeArgs = { '-frounding-math' } },
        cache = { retainInMemory = 0, directory = '/tmp/ccls-cache' },
      },
    })
  elseif lsp == 'rust_analyzer' then
    lspconfig[lsp].setup(config {
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
    })
  else
    lspconfig[lsp].setup(config())
  end
end

-- local rt = require("rust-tools")
--
-- rt.setup({
--   server = {
--     on_attach = function(_, bufnr)
--       -- Hover actions
--       vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--       -- Code action groups
--       vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--     end,
--   },
-- })

-- lua lsp
-- lspconfig.sumneko_lua.setup(require("bemu.lsp.lua-lsp"))
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
--
lspconfig.lua_ls.setup(config {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
