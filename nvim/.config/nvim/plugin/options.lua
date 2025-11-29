-- Defining alias for vim.opt.
local o = vim.opt
local g = vim.g
HOME = os.getenv 'HOME'

--- general
o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part
o.encoding = 'UTF-8'
o.showcmd = true
o.undodir = os.getenv 'HOME' .. '/.vim/undodir'
o.undofile = true -- set undotree to save to file
-- set.wrap = true -- set no soft wrap
o.mouse = 'a' -- enable clicking with the mouse
o.writebackup = false -- set to never save backup
o.swapfile = false -- set no swap file
o.backup = false -- set no backup file
o.termguicolors = true
o.autoread = true

-- indenting
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- number of space inserted for indentation
o.softtabstop = 2 -- number of spaces that a <Tab> counts for.
o.tabstop = 2 -- number of space in a tab
o.smartindent = true -- do smart auto indenting.
o.breakindent = true -- set every wrapped line will continue visually indented

--- searching
o.ignorecase = true -- set search to case insensitive
o.smartcase = true -- set to be case sensitive when there is capital letter, this needs set incsearch to work
o.incsearch = true -- for smartcase

-- editing
o.updatetime = 200 -- length of time to wait before triggering the plugin
o.timeoutlen = 250 -- shorten key timeout length for which-key
o.inccommand = 'split' -- preview substitutions live

--- scrolling
o.scrolloff = 10

-- vim.opt.isfname:append '@-@'
-- Always show the status line at the bottom, even if you only have one window open. global statusline
o.laststatus = 3
-- vim.o.ls = 0 -- laststatus
-- vim.o.ch = 0 -- command height

-- wrapping
o.wrap = true -- soft wrap lines
o.showbreak = '↪ '
o.breakindent = true -- make wrapped lines continue visually indented
-- no wrap, but if wrap enabled only wrap in white space
o.lbr = true
-- set.nowrap = true

-- special UI symbols
o.list = true -- show invisible characters.
-- o.listchars = 'extends:…,nbsp:␣,precedes:…,tab:> ,trail:·'
o.listchars = { eol = '↲', tab = '▸ ', trail = '·' }
-- o.fillchars = 'eob: ,fold:┄,foldclose:,foldopen:'

-- FINDING FILES:
-- Search down into subfolders
-- Provides tab-completion for all file-related tasks
-- set path+=**

-- Display all matching files when we tab complete
-- Nice menu when typing `:find *.py`
-- set wildmode=longest,list,full
o.wildmenu = true
-- Ignore files
o.wildignore = { '*/cache/*', '*/tmp/*', '*.pyc', '*_build/*', '**/.git/*' }

-- spell check
o.spell = true
o.spelllang = 'en_us,de_de'

-- ui
o.winborder = 'solid'
o.cursorline = true -- highlight the text line of the cursor
o.number = true -- show number line
o.relativenumber = true -- show relative number line
o.signcolumn = 'yes' -- set the line numbers on a even width
o.cmdheight = 1 -- height of the command bar, default: 1
o.numberwidth = 2

-- disable some default provider
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
