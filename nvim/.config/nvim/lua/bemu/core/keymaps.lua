-- leader to ,
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- Unbind some useless/annoying default key bindings.
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Make double-<Esc> clear search highlights
vim.keymap.set('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR><Esc>')

-- terminal mappings
-- so that you can just hit Esc to enter normal mode
vim.keymap.set('t', '<esc>', '<C-\\><C-N>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-W>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-W>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-W>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-W>l')

-- terminal
vim.keymap.set('n', '<leader>tn', function()
  require('bemu.core.funcs').vert_term()
end, { desc = 'New terminal in vert split' })
vim.keymap.set('n', '<leader>ts', ":lua require('bemu.core.funcs').horiz_term()<CR>", { desc = 'New terminal in horiz split' })

-- ctrl+s to save
vim.keymap.set('n', '<c-s>', '<cmd>update<CR>', { desc = 'write file' })
-- vim.keymap.set('n', '<leader><leader>w', '<cmd>update<CR>', { desc = 'write file' })

-- Keeping it centered
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- vim.keymap.set('n',"J", "mzJ`z")

-- paste with correct indent
-- vim.keymap.set('n',"p", "]p")

-- fix indentation
-- vim.keymap.set('n',"<leader>i", "gg=G<C-o><C-o>", { desc = 'fix [i]ndentation in buffer' })

-- navigate quickfix
vim.keymap.set('n', '<leader><leader>j', '<cmd>cn<CR>', { desc = '[j] next qf item' })
vim.keymap.set('n', '<leader><leader>k', '<cmd>cp<CR>', { desc = '[k] previous qf item' })

-- Line moving
---- Normal mode
-- vim.keymap.set('n', '<leader>j', '<cmd>m .+1<CR>==', { desc = 'move line up' })
-- vim.keymap.set('n', '<leader>k', '<cmd>m .-2<CR>==', { desc = 'move line down' })
---- Insert mode
-- vim.keymap.set('i', '<C-j>', '<ESC>:m .+1<CR>==gi', { desc = 'move line up' })
-- vim.keymap.set('i', '<C-k>', '<ESC>:m .-2<CR>==gi', { desc = 'move line down' })
---- Visual mode
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = 'move highlighted text down' })
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = 'move highlighted text up' })

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

vim.keymap.set('n', '<leader><leader>ca', '<cmd>w <bar> %bd <bar> e# <bar> bd#<cr>', { desc = '[c]lose [a]ll buffers except this one' })

-- Go on top of a word you want to change
-- Press cn or cN
-- Type the new word you want to replace it with
-- Smash that dot '.' multiple times to change all the other occurrences of the word
vim.keymap.set('n', 'cn', '*``cgn')
vim.keymap.set('n', 'cN', '*``cgN')

-- correct spell with ctrl+l
-- vim.keymap.set('i',"<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { desc = "correct spell" })

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
-- smart goto file
vim.keymap.set('n', '<leader>gf', function()
  require('bemu.core.funcs').goto_file()
end, { desc = '[g]oto [f]ile, create if not exist' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dd', function() require('telescope.builtin').diagnostics() end, { desc = 'Open [d]iagnostic list' })
