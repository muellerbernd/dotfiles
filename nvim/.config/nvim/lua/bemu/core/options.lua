-- Defining alias for vim.opt.
local set = vim.o
HOME = os.getenv 'HOME'
set.encoding = 'UTF-8'
-- set.termencoding = "UTF-8"
set.showcmd = true
set.termguicolors = true
-- Redraw when needed
set.lazyredraw = true
set.undodir = os.getenv 'HOME' .. '/.vim/undodir'
set.undofile = true -- set undotree to save to file
set.number = true
set.numberwidth = 2
set.relativenumber = true -- set line number
-- set.wrap = true -- set no soft wrap
set.linebreak = true -- only break at words
set.list = false -- so softwrapping works
set.tabstop = 4
set.softtabstop = 4 -- set tab size
set.shiftwidth = 4 -- affect amount of indentation
set.expandtab = true -- set that tab will insert softabstop amount of space characters
set.mouse = 'a' -- enable clicking with the mouse
set.writebackup = false -- set to never save backup
set.swapfile = false -- set no swap file
set.backup = false -- set no backup file
set.breakindent = true -- set every wrapped line will continue visually indented
set.smartindent = true -- set smart indentation
set.ignorecase = true -- set search to case insensitive
set.smartcase = true -- set to be case sensitive when there is capital letter, this needs set incsearch to work
set.incsearch = true -- for smartcase
set.hidden = true -- so multiple buffers can be open
set.updatetime = 50 -- update faster for autocompletion
set.showmode = true -- set that vim mode is hidden, to incorporate for lightline plugin
set.modeline = true
set.signcolumn = 'yes' -- set the line numbers on a even width
set.scrolloff = 8
set.colorcolumn = '80'
vim.opt.isfname:append '@-@'
-- Always show the status line at the bottom, even if you only have one window open. global statusline
set.laststatus = 3
-- vim.o.ls = 0 -- laststatus
-- vim.o.ch = 0 -- command height
-- The backspace key has slightly unintuitive behavior by default. For example,
-- by default, you can't backspace before the insertion point set with 'i'.
-- This configuration makes backspace behave more reasonably, in that you can
-- backspace over anything.
-- set.backspace = {'indent', 'eol', 'start'}
-- Show hidden characters, tabs, trailing whitespace
set.list = true
vim.opt.listchars = { eol = '↲', tab = '▸ ', trail = '·' }
-- vim.opt.listchars = { eol = "↲", tab = "▸ ", trail = "·" , space = "⋅"}
-- set system clipboard as default clipboard
-- set.clipboard = "unnamedplus"
set.formatoptions = 'l'
-- set.noswapfile = true
-- no wrap, but if wrap enabled only wrap in white space
set.lbr = true
-- set.nowrap = true

-- FINDING FILES:
-- Search down into subfolders
-- Provides tab-completion for all file-related tasks
-- set path+=**

-- Display all matching files when we tab complete
-- Nice menu when typing `:find *.py`
-- set wildmode=longest,list,full
set.wildmenu = true
-- Ignore files
vim.opt.wildignore = { '*/cache/*', '*/tmp/*', '*.pyc', '*_build/*', '**/.git/*' }

-- spell check
set.spell = true
