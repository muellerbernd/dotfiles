local present, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

nvim_treesitter.setup {
  ensure_installed = {
    'bash',
    'cpp',
    'dockerfile',
    'html',
    'css',
    'json',
    'javascript',
    'latex',
    'bibtex',
    'lua',
    'python',
    'regex',
    'rust',
    'toml',
    'yaml',
    'go',
    'markdown_inline',
    'markdown',
    'vim',
    'dot',
    'haskell',
    'glimmer',
    'sql',
    'nix',
    'c',
  },
  highlight = {
    enable = true,
    disable = function(_, bufnr)
      return vim.b[bufnr].large_buf
    end,
    additional_vim_regex_highlighting = { 'lua', 'markdown', 'hbs' },
  },
  -- matchup = {enable = true},
  indent = { enable = true },
  -- rainbow = {
  --     enable = false,
  --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --     max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --     colors = { "#FF79C6", "#A4FFFF", "#50fa7b", "#FFFFA5", "#FF92DF", "#5e81ac", "#b48ead" }, -- table of hex strings
  -- },
  autopairs = { enable = true },
  refactor = { highlight_definitions = { enable = true } },
  autotag = { enable = true },
  context_commentstring = { enable = true },
  incremental_selection = {
    enable = true,
    -- These are the default keymaps, which I can lookup via help, but still putting
    -- them here for easier access.
    -- keymaps = {
    --     init_selection = "gnn",
    --     node_incremental = "grn",
    --     scope_incremental = "grc",
    --     node_decremental = "grm",
    -- },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['ak'] = { query = '@block.outer', desc = 'around block' },
        ['ik'] = { query = '@block.inner', desc = 'inside block' },
        ['ac'] = { query = '@class.outer', desc = 'around class' },
        ['ic'] = { query = '@class.inner', desc = 'inside class' },
        ['a?'] = { query = '@conditional.outer', desc = 'around conditional' },
        ['i?'] = { query = '@conditional.inner', desc = 'inside conditional' },
        ['af'] = { query = '@function.outer', desc = 'around function ' },
        ['if'] = { query = '@function.inner', desc = 'inside function ' },
        ['al'] = { query = '@loop.outer', desc = 'around loop' },
        ['il'] = { query = '@loop.inner', desc = 'inside loop' },
        ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
        ['ia'] = { query = '@parameter.inner', desc = 'inside argument' },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']k'] = { query = '@block.outer', desc = 'Next block start' },
        [']f'] = { query = '@function.outer', desc = 'Next function start' },
        [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
      },
      goto_next_end = {
        [']K'] = { query = '@block.outer', desc = 'Next block end' },
        [']F'] = { query = '@function.outer', desc = 'Next function end' },
        [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
      },
      goto_previous_start = {
        ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
        ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
        ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
      },
      goto_previous_end = {
        ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
        ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
        ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
        ['>F'] = { query = '@function.outer', desc = 'Swap next function' },
        ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
      },
      swap_previous = {
        ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
        ['<F'] = { query = '@function.outer', desc = 'Swap previous function' },
        ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
      },
    },
  },
  -- lsp_interop = {
  --     enable = true,
  --     border = "none",
  --     peek_definition_code = {
  --         ["<leader>df"] = "@function.outer",
  --         ["<leader>dF"] = "@class.outer",
  --     },
  -- },
}
vim.o.foldlevel = 5
-- vim.o.foldmethod = "expr"
vim.o.foldmethod = 'indent'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

require('treesitter-context').setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    default = {
      'class',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
      'interface',
      'struct',
      'enum',
    },
    -- Patterns for specific filetypes
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    tex = {
      'chapter',
      'section',
      'subsection',
      'subsubsection',
    },
    haskell = {
      'adt',
    },
    rust = {
      'impl_item',
      'match',
    },
    terraform = {
      'block',
      'object_elem',
      'attribute',
    },
    scala = {
      'object_definition',
    },
    vhdl = {
      'process_statement',
      'architecture_body',
      'entity_declaration',
    },
    markdown = {
      'section',
    },
    elixir = {
      'anonymous_function',
      'arguments',
      'block',
      'do_block',
      'list',
      'map',
      'tuple',
      'quoted_content',
    },
    json = {
      'pair',
    },
    typescript = {
      'export_statement',
    },
    yaml = {
      'block_mapping_pair',
    },
  },
  exact_patterns = {
    -- Example for a specific filetype with Lua patterns
    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
    -- exactly match "impl_item" only)
    -- rust = true,
  },

  -- [!] The options below are exposed but shouldn't require your attention,
  --     you can safely ignore them.

  zindex = 20, -- The Z-index of the context window
  mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
}
