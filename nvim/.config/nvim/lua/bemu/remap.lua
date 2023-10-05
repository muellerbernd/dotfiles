-- leader to ,
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Unbind some useless/annoying default key bindings.
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', '<Space>', '<Nop>')

-- Make double-<Esc> clear search highlights
vim.keymap.set('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR><Esc>')

-- so that you can just hit Esc to enter normal mode
vim.keymap.set('t', '<esc>', '<C-\\><C-N>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-W>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-W>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-W>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-W>l')

-- terminal
vim.keymap.set('n', '<Leader>tn', function()
  require('bemu.funcs').vert_term()
end, { desc = 'New terminal in vert split' })
vim.keymap.set('n', '<Leader>ts', ":lua require('bemu.funcs').horiz_term()<CR>", { desc = 'New terminal in horiz split' })

-- ctrl+s to save
vim.keymap.set('n', '<c-s>', '<cmd>update<CR>', { desc = 'write file' })
vim.keymap.set('n', '<leader><leader>w', '<cmd>update<CR>', { desc = 'write file' })

-- Keeping it centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- vim.keymap.set('n',"J", "mzJ`z")

-- paste with correct indent
-- vim.keymap.set('n',"p", "]p")

-- fix indentation
-- vim.keymap.set('n',"<leader>i", "gg=G<C-o><C-o>")

-- navigate quickfix
vim.keymap.set('n', '<leader><leader>j', '<cmd>cn<CR>', { desc = '[j] next qf item' })
vim.keymap.set('n', '<leader><leader>k', '<cmd>cp<CR>', { desc = '[k] previous qf item' })

-- Line moving
---- Normal mode
vim.keymap.set('n', '<leader>j', '<cmd>m .+1<CR>==', { desc = 'move line up' })
vim.keymap.set('n', '<leader>k', '<cmd>m .-2<CR>==', { desc = 'move line down' })
---- Insert mode
vim.keymap.set('i', '<C-j>', '<ESC>:m .+1<CR>==gi', { desc = 'move line up' })
vim.keymap.set('i', '<C-k>', '<ESC>:m .-2<CR>==gi', { desc = 'move line down' })
---- Visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = 'move highlighted text down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = 'move highlighted text up' })

vim.keymap.set('n', '<leader>y', '"+yy', { desc = 'copy to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'paste after from clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'paste before from clipboard' })

-- Don't leave visual mode after indenting
vim.keymap.set('v', '>', '>gv^')
vim.keymap.set('v', '<', '<gv^')

-- buffer management
-- Previous/next buffer
vim.keymap.set('n', '<C-PageDown>', '<cmd>if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>')
vim.keymap.set('n', '<C-PageUp>', '<cmd>if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>')

-- Close the current buffer and move to the previous one
-- This replicates the idea of closing a tab
-- vim.keymap.set('n',"<leader>bq", "<cmd>bp <BAR> bd #<CR>")
vim.keymap.set('n', '<M-x>', '<cmd>bp <BAR> bd! #<CR>')

-- To open a new empty buffer
-- This replaces :tabnew which I used to bind to this mapping
-- vim.keymap.set('n',"<leader>T", "<cmd>enew<cr>", { desc = "open new empty buffer" })

vim.keymap.set('n', '<leader>ca', '<cmd>w <bar> %bd <bar> e# <bar> bd#<cr>', { desc = '[c]lose [a]ll buffers except this one' })

-- Go on top of a word you want to change
-- Press cn or cN
-- Type the new word you want to replace it with
-- Smash that dot '.' multiple times to change all the other occurrences of the word
vim.keymap.set('n', 'cn', '*``cgn')
vim.keymap.set('n', 'cN', '*``cgN')

-- correct spell with ctrl+l
-- vim.keymap.set('i',"<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "correct spell" })

-- plugin mappings
-- formatter
vim.keymap.set('n', '<F3>', '<cmd>Neoformat<CR>')
-- vim-header settings
vim.keymap.set('n', '<leader>ah', '<cmd>AddHeader<CR>', { desc = '[a]dd [h]eader to file' })
-- todo
vim.keymap.set('n', '<leader>td', '<cmd>TodoTelescope<CR>', { desc = 'list current [t]o[d]os' })

-- telescope
-- local telescope_mapper = require("bemu.telescope.mappings")
-- vim.keymap.set('n','<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set(
  'n',
  '<leader>ff',
  "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h'), find_command={'rg','--ignore','--hidden','--files'}, prompt_prefix='🔍' }) <cr>",
  { desc = '[f]ind [f]iles' }
)
vim.keymap.set('n', '<leader>fg', "<cmd>lua require('bemu.telescope.funcs').live_grep()<cr>", { desc = '[f]ind with [g]rep' })
vim.keymap.set('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { desc = '[f]ind [b]uffers' })
vim.keymap.set('n', '<leader>fS', "<cmd>lua require('telescope.builtin').spell_suggest()<cr>", { desc = '[f]ix [S]pell' })
vim.keymap.set('n', '<leader>fG', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", { desc = '[f]ind with [G]rep in current buffer' })
vim.keymap.set('n', '<leader>fh', "<cmd>lua require('bemu.telescope.funcs').help_tags()<cr>", { desc = '[f]ind in [h]elp' })
vim.keymap.set('n', '<leader>fl', "<cmd>lua require('telescope.builtin').resume()<cr>", { desc = '[f]ind in [l]ast picker' })
vim.keymap.set('n', '<leader>fT', "<cmd>lua require('telescope.builtin').treesitter()<cr>", { desc = '[f]ind via [T]reesitter' })
vim.keymap.set('n', '<leader>fR', "<cmd>lua require('telescope.builtin').registers()<CR>", { desc = '[f]ind in [r]egisters' })
vim.keymap.set('n', '<leader>en', "<cmd>lua require('bemu.telescope.funcs').edit_neovim()<cr>", { desc = '[e]dit [n]eovim config' })
vim.keymap.set('n', '<leader>el', "<cmd>lua require('bemu.telescope.funcs').local_plugins()<cr>", { desc = 'list [l]ocal [p]lugins' })
vim.keymap.set('n', '<leader>qr', "<cmd>lua require('bemu.telescope.funcs').reload()<cr>", { desc = '[q]uick [r]eload plugins' })
vim.keymap.set('n', '<leader>fr', "<cmd>lua require('bemu.telescope.funcs').file_browser()<cr>", { desc = '[f]ile b[r]owser' })
-- telescope tasks
vim.keymap.set('n', '<leader>ft', "<cmd>lua require('telescope').extensions.asynctasks.all()<CR>", { desc = '[f]ind in configured async[t]asks' })
-- telescope wiki
vim.keymap.set('n', '<leader>fw', "<cmd>lua require('bemu.telescope.funcs').list_mywikis()<cr>", { desc = '[f]ind configured [w]ikis' })

vim.keymap.set('n', '<F8>', "<cmd>lua require('bemu.telescope.funcs').current_buffer_tags()<cr>", { desc = 'show current buffer tags' })
vim.keymap.set('n', '<leader>fs', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { desc = '[f]ind via lsp [s]ymbols' })

-- Dap debugger
vim.keymap.set('n', '<leader>br', "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = 'dap set [br]eakpoint' })
vim.keymap.set('n', '<leader>co', "<cmd>lua require('dap').continue()<CR>", { desc = 'dap [co]ntinue' })
vim.keymap.set('n', '<leader>so', "<cmd>lua require('dap').step_over()<CR>", { desc = 'dap [s]tep [o]ver' })
vim.keymap.set('n', '<leader>si', "<cmd>lua require('dap').step_into()<CR>", { desc = 'dap [s]tep [i]nto' })
vim.keymap.set('n', '<leader>re', "<cmd>lua require('dap').repl.open()<CR>", { desc = 'dap [re]pl open' })
vim.keymap.set('n', '<leader>dt', ':lua require("dapui").toggle()<CR>', { desc = '[d]apui [t]oggle' })

-- trouble
-- Lua
-- vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})

-- preview markdown
vim.keymap.set('n', '<F4>', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'toggle MarkdownPreview' })

-- latex-previewer
vim.keymap.set('n', '<F5>', "<cmd>lua require('latex-previewer').preview()<cr>", { desc = 'open latex-previewer' })

-- preview code with LSP code actions applied
vim.keymap.set('n', '<leader>ap', ':lua require("actions-preview").code_actions()<CR>', { desc = '[a]ction [p]review for code actions' })

-- toggle custom stuff
vim.keymap.set('n', '<leader><leader>t', function()
  local word = vim.fn.expand '<cword>'

  local word_mapping = {
    ['true'] = 'false',
    ['True'] = 'False',
    ['yes'] = 'no',
    ['on'] = 'off',
    ['ON'] = 'OFF',
  }

  word_mapping = vim.tbl_add_reverse_lookup(word_mapping)

  local new_word = word_mapping[word]

  if not new_word then
    return
  end

  local cmd = 'normal ciw' .. new_word

  vim.cmd(cmd)
end, { desc = '[t]oggle words to opposite' })

vim.keymap.set('n', '<leader>qf', function()
  local qf_test = vim.fn.getqflist({ winid = 0 }).winid
  -- print(qf_test)
  -- print(vim.inspect(qf_test))
  if qf_test == 0 then
    vim.cmd 'copen'
  else
    vim.cmd 'cclose'
  end
end, { desc = 'toggle [q]ick[f]ix list' })

vim.keymap.set('n', '<leader>gf', function()
  require('bemu.funcs').goto_file()
end, { desc = '[g]oto [f]ile, create if not exist' })
