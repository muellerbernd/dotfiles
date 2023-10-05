-- Set completeopt to have a better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local source_mapping = {
  nvim_lsp = '[LSP]',
  buffer = '[Buffer]',
  nvim_lua = '[Lua]',
  cmp_tabnine = '[TN]',
  path = '[Path]',
  calc = '[Calc]',
  treesitter = '[TS]',
  fuzzy_buffer = '[FZ]',
  fuzzy_path = '[FZ]',
  rg = '[RG]',
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

local luasnip = require 'luasnip'
local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup {
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
  -- completion = {keyword_length = 2},
  confirmation = { default_behavior = cmp.ConfirmBehavior.Replace },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = false })
      local menu = source_mapping[entry.source.name] or ('[' .. entry.source.name .. ']')
      if entry.source.name == 'cmp_tabnine' then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. ' ' .. menu
        end
        vim_item.kind = ''
      end
      vim_item.menu = menu
      return vim_item
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ["<C-Space>"] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      -- select = true,
    },
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --         cmp.select_next_item()
    --     elseif luasnip.expand_or_jumpable() then
    --         luasnip.expand_or_jump()
    --     elseif has_words_before() then
    --         cmp.complete()
    --     else
    --         fallback()
    --     end
    -- end, { "i", "s" }),
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --         cmp.select_prev_item()
    --     elseif luasnip.jumpable(-1) then
    --         luasnip.jump(-1)
    --     else
    --         fallback()
    --     end
    -- end, { "i", "s" }),
  },
  sources = cmp.config.sources {
    -- { name = "nvim_lua" },
    -- { name = "nvim_lsp" },
    -- { name = "luasnip" },
    -- { name = "buffer" },
    -- { name = "path" },
    { name = 'nvim_lsp', priority_weight = 1000 },
    { name = 'luasnip', priority_weight = 750 },
    {
      name = 'buffer',
      -- max_item_count = 8,
      priority_weight = 500,
      -- option = {
      --     get_bufnrs = function()
      --         return vim.api.nvim_list_bufs()
      --     end,
      -- },
    },
    { name = 'path', priority_weight = 250 },
    -- {
    --     name = "rg",
    --     keyword_length = 3,
    --     max_item_count = 5,
    --     priority_weight = 60,
    --     option = { additional_arguments = "--smart-case --hidden" },
    -- },
    -- {name = "luasnip", options = {use_show_condition = false}},
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    -- {name = "ultisnips"},
    -- {name = "cmp_tabnine"},
    -- {name = "buffer"},
    -- {name = "path"},
    -- {name = "treesitter"},
    -- {name = "rg"}
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
  preselect = cmp.PreselectMode.None,
  experimental = {
    ghost_text = { hl_group = 'Comment' },
    horizontal_search = true,
  },
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

-- vim.cmd([[
--     autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--     ]])

-- vim.cmd([[
-- autocmd FileType tex,latex,context,plaintex lua require'cmp'.setup.buffer {
-- \   sources = {
-- \     { name = 'spell' },
-- \   },
-- \ }
-- ]])

-- local tabnine = require("cmp_tabnine.config")
-- tabnine:setup(
--     {
--         max_lines = 1000,
--         max_num_results = 20,
--         sort = true,
--         run_on_every_keystroke = true
--     }
-- )
