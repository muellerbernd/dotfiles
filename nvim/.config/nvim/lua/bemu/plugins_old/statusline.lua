local lualine = require 'lualine'
-- local tabline = require "tabline"
-- tabline.setup {
--     -- Defaults configuration options
--     enable = true,
--     options = {
--         -- If lualine is installed tabline will use separators configured in lualine by default.
--         -- These options can be used to override those settings.
--         section_separators = {"", ""},
--         component_separators = {"", ""},
--         max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
--         show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
--         show_devicons = true, -- this shows devicons in buffer section
--         show_bufnr = false, -- this appends [bufnr] to buffer section,
--         show_filename_only = true -- shows base filename only instead of relative path in filename
--     }
-- }

-- Color table for highlights
-- stylua: ignore
local colors = {
    -- bg       = '#202328',
    -- fg       = '#bbc2cf',
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67"
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
local function getLines()
  return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. '/' .. tostring(vim.api.nvim_buf_line_count(0))
end

local function currentfolder()
  return vim.fn.expand '%:p:h:t'
end

local function currentpath()
  -- return vim.fn.expand('%:p:h')
  local name = vim.fn.expand '%:p'
  return vim.fn.fnamemodify(vim.fn.resolve(name), ':~:.')
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    -- theme = 'gruvbox-flat',
    theme = 'auto',
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = { 'mode' },
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  -- tabline = {
  --     lualine_a = {},
  --     lualine_b = {},
  --     lualine_c = {tabline.tabline_buffers},
  --     lualine_x = {tabline.tabline_tabs},
  --     lualine_y = {},
  --     lualine_z = {}
  -- },
  extensions = {},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- ins_left {
--     -- filesize component
--     "filesize",
--     cond = conditions.buffer_not_empty
-- }

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  -- color = {fg = colors.magenta, gui = "bold"}
}

-- ins_left {"location"}
--
-- ins_left {"progress", color = {fg = colors.fg, gui = "bold"}}

-- ins_left {"filetype", colored = true}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.blue },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- function()
  --     local command = ":call vista#cursor#NearestSymbol()"
  --     local msg = vim.api.nvim_exec(command, false)
  --     return msg
  -- end,
  'nvim_treesitter#statusline',
  icon = 'ƒ:',
}
-- ins_left {
--     -- Lsp server name .
--     function()
--         local msg = "No Active Lsp"
--         local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--         local clients = vim.lsp.get_active_clients()
--         if next(clients) == nil then return msg end
--         for _, client in ipairs(clients) do
--             local filetypes = client.config.filetypes
--             if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--                 return client.name
--             end
--         end
--         return msg
--     end,
--     icon = " LSP:",
--     color = {fg = "#ffffff", gui = "bold"}
-- }

-- ins_left {
--     'lsp_progress',
-- display_components = {"lsp_client_name", {"title", "percentage", "message"}},
-- -- With spinner
-- -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
-- colors = {
--     percentage = colors.cyan,
--     title = colors.cyan,
--     message = colors.cyan,
--     spinner = colors.cyan,
--     lsp_client_name = colors.magenta,
--     use = true
-- },
-- separators = {
--     component = " ",
--     progress = " | ",
--     message = {pre = "(", post = ")"},
--     percentage = {pre = "", post = "%% "},
--     title = {pre = "", post = ": "},
--     lsp_client_name = {pre = "[", post = "]"},
--     spinner = {pre = "", post = ""},
--     message = {commenced = "In Progress", completed = "Completed"}
-- },
-- display_components = {"lsp_client_name", "spinner", {"title", "percentage", "message"}},
-- timer = {progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000},
-- spinner_symbols = {"🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 "}
-- }

ins_right { getLines }

-- Add components to right sections
-- ins_right {
--     'o:encoding', -- option component same as &encoding in viml
--     fmt = string.upper, -- I'm not sure why it's upper case either ;)
--     cond = conditions.hide_in_width,
--     -- color = { fg = colors.green, gui = 'bold' },
-- }

-- ins_right {
--     'fileformat',
--     fmt = string.upper,
--     icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--     -- color = { fg = colors.green, gui = 'bold' },
-- }

ins_right {
  'branch',
  icon = '',
  -- color = {fg = colors.green, gui = "bold"}
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  -- cond = conditions.hide_in_width,
}

-- Now don't forget to initialize lualine
lualine.setup(config)
