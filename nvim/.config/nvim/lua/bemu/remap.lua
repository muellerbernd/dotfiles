-- remap function
-- local function map(mode, shortcut, command)
--     vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
-- end
-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- function for normal mode
local function nmap(shortcut, command, opts)
  map('n', shortcut, command, opts)
end

-- function for insert mode
local function imap(shortcut, command, opts)
  map('i', shortcut, command, opts)
end

-- function for visual mode
local function vmap(shortcut, command, opts)
  map('v', shortcut, command, opts)
end

-- function for terminal mode
local function tmap(shortcut, command, opts)
  map('t', shortcut, command, opts)
end
-- leader to ,
vim.g.mapleader = ','

-- Unbind some useless/annoying default key bindings.
nmap('Q', '<Nop>')
nmap('<Space>', '<Nop>')

-- Make double-<Esc> clear search highlights
nmap('<Esc><Esc>', '<Esc>:nohlsearch<CR><Esc>')

-- so that you can just hit Esc to enter normal mode
tmap('<esc>', '<C-\\><C-N>')
tmap('jk', '<C-\\><C-n>')
tmap('<C-h>', '<C-\\><C-n><C-W>h')
tmap('<C-j>', '<C-\\><C-n><C-W>j')
tmap('<C-k>', '<C-\\><C-n><C-W>k')
tmap('<C-l>', '<C-\\><C-n><C-W>l')

-- terminal
nmap('<Leader>tn', ":lua require('bemu.funcs').vert_term()<CR>", { desc = 'New terminal in vert split' })
nmap('<Leader>ts', ":lua require('bemu.funcs').horiz_term()<CR>", { desc = 'New terminal in horiz split' })

-- ctrl+s to save
nmap('<c-s>', '<cmd>update<CR>', { desc = 'write file' })
nmap('<leader><leader>w', '<cmd>update<CR>', { desc = 'write file' })

-- Keeping it centered
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
-- nmap("J", "mzJ`z")

-- paste with correct indent
-- nmap("p", "]p")

-- fix indentation
-- nmap("<leader>i", "gg=G<C-o><C-o>")

-- navigate quickfix
nmap('<leader><leader>j', '<cmd>cn<CR>', { desc = '[j] next qf item' })
nmap('<leader><leader>k', '<cmd>cp<CR>', { desc = '[k] previous qf item' })

-- Line moving
---- Normal mode
nmap('<leader>j', '<cmd>m .+1<CR>==', { desc = 'move line up' })
nmap('<leader>k', '<cmd>m .-2<CR>==', { desc = 'move line down' })
---- Insert mode
imap('<C-j>', '<ESC>:m .+1<CR>==gi', { desc = 'move line up' })
imap('<C-k>', '<ESC>:m .-2<CR>==gi', { desc = 'move line down' })
---- Visual mode
vmap('J', ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = 'move highlighted text down' })
vmap('K', ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = 'move highlighted text up' })

nmap('<leader>y', '"+yy', { desc = 'copy to clipboard' })
nmap('<leader>p', '"+p', { desc = 'paste after from clipboard' })
nmap('<leader>P', '"+P', { desc = 'paste before from clipboard' })

-- Don't leave visual mode after indenting
vmap('>', '>gv^')
vmap('<', '<gv^')

-- buffer management
-- Previous/next buffer
nmap('<C-PageDown>', '<cmd>if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>')
nmap('<C-PageUp>', '<cmd>if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>')

-- Close the current buffer and move to the previous one
-- This replicates the idea of closing a tab
-- nmap("<leader>bq", "<cmd>bp <BAR> bd #<CR>")
nmap('<M-x>', '<cmd>bp <BAR> bd! #<CR>')

-- To open a new empty buffer
-- This replaces :tabnew which I used to bind to this mapping
-- nmap("<leader>T", "<cmd>enew<cr>", { desc = "open new empty buffer" })

nmap('<leader>ca', '<cmd>w <bar> %bd <bar> e# <bar> bd#<cr>', { desc = '[c]lose [a]ll buffers except this one' })

-- Go on top of a word you want to change
-- Press cn or cN
-- Type the new word you want to replace it with
-- Smash that dot '.' multiple times to change all the other occurrences of the word
nmap('cn', '*``cgn')
nmap('cN', '*``cgN')

-- correct spell with ctrl+l
-- imap("<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "correct spell" })

-- plugin mappings
-- formatter
nmap('<F3>', '<cmd>Neoformat<CR>')
-- vim-header settings
nmap('<leader>ah', '<cmd>AddHeader<CR>', { desc = '[a]dd [h]eader to file' })
-- todo
nmap('<leader>td', '<cmd>TodoTelescope<CR>', { desc = 'list current [t]o[d]os' })

-- telescope
-- local telescope_mapper = require("bemu.telescope.mappings")
nmap(
  '<leader>ff',
  "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h'), find_command={'rg','--ignore','--hidden','--files'}, prompt_prefix='🔍' }) <cr>",
  { desc = '[f]ind [f]iles' }
)
nmap('<leader>fg', "<cmd>lua require('bemu.telescope.funcs').live_grep()<cr>", { desc = '[f]ind with [g]rep' })
nmap('<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { desc = '[f]ind [b]uffers' })
nmap('<leader>fS', "<cmd>lua require('telescope.builtin').spell_suggest()<cr>", { desc = '[f]ix [S]pell' })
nmap('<leader>fG', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", { desc = '[f]ind with [G]rep in current buffer' })
nmap('<leader>fh', "<cmd>lua require('bemu.telescope.funcs').help_tags()<cr>", { desc = '[f]ind in [h]elp' })
nmap('<leader>fl', "<cmd>lua require('telescope.builtin').resume()<cr>", { desc = '[f]ind in [l]ast picker' })
nmap('<leader>fT', "<cmd>lua require('telescope.builtin').treesitter()<cr>", { desc = '[f]ind via [T]reesitter' })
nmap('<leader>fR', "<cmd>lua require('telescope.builtin').registers()<CR>", { desc = '[f]ind in [r]egisters' })
nmap('<leader>en', "<cmd>lua require('bemu.telescope.funcs').edit_neovim()<cr>", { desc = '[e]dit [n]eovim config' })
nmap('<leader>el', "<cmd>lua require('bemu.telescope.funcs').local_plugins()<cr>", { desc = 'list [l]ocal [p]lugins' })
nmap('<leader>qr', "<cmd>lua require('bemu.telescope.funcs').reload()<cr>", { desc = '[q]uick [r]eload plugins' })
nmap('<leader>fr', "<cmd>lua require('bemu.telescope.funcs').file_browser()<cr>", { desc = '[f]ile b[r]owser' })
-- telescope tasks
nmap('<leader>ft', "<cmd>lua require('telescope').extensions.asynctasks.all()<CR>", { desc = '[f]ind in configured async[t]asks' })
-- telescope wiki
nmap('<leader>fw', "<cmd>lua require('bemu.telescope.funcs').list_mywikis()<cr>", { desc = '[f]ind configured [w]ikis' })

nmap('<F8>', "<cmd>lua require('bemu.telescope.funcs').current_buffer_tags()<cr>", { desc = 'show current buffer tags' })
nmap('<leader>fs', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { desc = '[f]ind via lsp [s]ymbols' })

-- Dap debugger
nmap('<leader>br', "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = 'dap set [br]eakpoint' })
nmap('<leader>co', "<cmd>lua require('dap').continue()<CR>", { desc = 'dap [co]ntinue' })
nmap('<leader>so', "<cmd>lua require('dap').step_over()<CR>", { desc = 'dap [s]tep [o]ver' })
nmap('<leader>si', "<cmd>lua require('dap').step_into()<CR>", { desc = 'dap [s]tep [i]nto' })
nmap('<leader>re', "<cmd>lua require('dap').repl.open()<CR>", { desc = 'dap [re]pl open' })
nmap('<leader>dt', ':lua require("dapui").toggle()<CR>', { desc = '[d]apui [toggle]' })

-- trouble
-- Lua
-- vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})

-- preview markdown
nmap('<F4>', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'toggle MarkdownPreview' })

-- latex-previewer
nmap('<F5>', "<cmd>lua require('latex-previewer').preview()<cr>", { desc = 'open latex-previewer' })

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
