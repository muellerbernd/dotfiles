-- Defining alias for vim.opt.
local opt = vim.opt
HOME = os.getenv 'HOME'
opt.encoding = 'UTF-8'
-- set.termencoding = "UTF-8"
opt.showcmd = true
opt.termguicolors = true
-- Redraw when needed
-- set.lazyredraw = true
opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
opt.undofile = true -- set undotree to save to file
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true -- set line number
-- set.wrap = true -- set no soft wrap
opt.linebreak = true      -- only break at words
opt.list = false          -- so softwrapping works
opt.tabstop = 4
opt.softtabstop = 4       -- set tab size
opt.shiftwidth = 4        -- affect amount of indentation
opt.expandtab = true      -- set that tab will insert softabstop amount of space characters
opt.mouse = 'a'           -- enable clicking with the mouse
opt.writebackup = false   -- set to never save backup
opt.swapfile = false      -- set no swap file
opt.backup = false        -- set no backup file
opt.breakindent = true    -- set every wrapped line will continue visually indented
opt.smartindent = true    -- set smart indentation
opt.ignorecase = true     -- set search to case insensitive
opt.smartcase = true      -- set to be case sensitive when there is capital letter, this needs set incsearch to work
opt.incsearch = true      -- for smartcase
opt.hidden = true         -- so multiple buffers can be open
opt.updatetime = 250      -- update faster for autocompletion
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300
opt.showmode = true    -- set that vim mode is hidden, to incorporate for lightline plugin
opt.modeline = true
opt.signcolumn = 'yes' -- set the line numbers on a even width
opt.scrolloff = 10
opt.colorcolumn = '80'
-- vim.opt.isfname:append '@-@'
-- Always show the status line at the bottom, even if you only have one window open. global statusline
opt.laststatus = 3
-- vim.o.ls = 0 -- laststatus
-- vim.o.ch = 0 -- command height
-- The backspace key has slightly unintuitive behavior by default. For example,
-- by default, you can't backspace before the insertion point set with 'i'.
-- This configuration makes backspace behave more reasonably, in that you can
-- backspace over anything.
-- set.backspace = {'indent', 'eol', 'start'}
-- Show hidden characters, tabs, trailing whitespace
opt.list = true
vim.opt.listchars = { eol = '↲', tab = '▸ ', trail = '·' }
-- vim.opt.listchars = { eol = "↲", tab = "▸ ", trail = "·" , space = "⋅"}
-- set system clipboard as default clipboard
-- set.clipboard = "unnamedplus"
-- set.noswapfile = true
-- no wrap, but if wrap enabled only wrap in white space
opt.lbr = true
-- set.nowrap = true

-- FINDING FILES:
-- Search down into subfolders
-- Provides tab-completion for all file-related tasks
-- set path+=**

-- Display all matching files when we tab complete
-- Nice menu when typing `:find *.py`
-- set wildmode=longest,list,full
opt.wildmenu = true
-- Ignore files
opt.wildignore = { '*/cache/*', '*/tmp/*', '*.pyc', '*_build/*', '**/.git/*' }

-- spell check
opt.spell = true
