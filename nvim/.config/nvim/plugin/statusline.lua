-- local M = {}
-- -- mode_map copied from:
-- -- https://github.com/nvim-lualine/lualine.nvim/blob/5113cdb32f9d9588a2b56de6d1df6e33b06a554a/lua/lualine/utils/mode.lua
-- -- Copyright (c) 2020-2021 hoob3rt
-- -- MIT license, see LICENSE for more details.
local mode_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['nov'] = 'O-PENDING',
  ['noV'] = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['nt'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['\22s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}
--
-- vim.cmd([[
--   highlight WinBar           guifg=#BBBBBB gui=bold
--   highlight WinBarNC         guifg=#888888 gui=bold
--   highlight WinBarLocation   guifg=#888888 gui=bold
--   highlight WinBarModified   guifg=#d7d787 gui=bold
--   highlight WinBarGitDirty   guifg=#d7afd7 gui=bold
--   highlight WinBarIndicator  guifg=#5fafd7 gui=bold
--   highlight WinBarInactive   guibg=#3a3a3a guifg=#777777 gui=bold
--   highlight ModeC guibg=#dddddd guifg=#101010 gui=bold " COMMAND
--   highlight ModeI guibg=#ffff5f guifg=#353535 gui=bold " INSERT
--   highlight ModeT guibg=#95e454 guifg=#353535 gui=bold " TERMINAL
--   highlight ModeN guibg=#87d7ff guifg=#353535 gui=bold " NORMAL
--   highlight ModeN guibg=#5fafd7 guifg=#262626 gui=bold " NORMAL
--   highlight ModeV guibg=#c586c0 guifg=#353535 gui=bold " VISUAL
--   highlight ModeR guibg=#f44747 guifg=#353535 gui=bold " REPLACE
--   highlight StatusLine              guibg=#303030 guifg=#999999
--   highlight StatusLineGit  gui=bold guibg=#3a3a3a guifg=#c586c0
--   highlight StatusLineCwd  gui=bold guibg=#3a3a3a guifg=#999999
--   highlight StatusLineFile gui=bold guibg=#303030 guifg=#bbbbbb
--   highlight StatusLineMod           guibg=#303030 guifg=#d7d787
--   highlight StatusLineError         guibg=#303030 guifg=#ff0000
--   highlight StatusLineInfo          guibg=#303030 guifg=#87d7ff
--   highlight StatusLineHint          guibg=#303030 guifg=#ffffd7
--   highlight StatusLineWarn          guibg=#303030 guifg=#d7d700
--   highlight StatusLineChanges       guibg=#303030 guifg=#c586c0
--   highlight StatusLineOutside       guibg=#3a3a3a guifg=#999999
--   highlight StatusLineTransition1   guibg=#303030 guifg=#1c1c1c
--   highlight StatusLineTransition2   guibg=#3a3a3a guifg=#1c1c1c
-- ]])
--
-- function M.mode()
--     local current_mode = vim.api.nvim_get_mode().mode
--     return string.format(" %s ", modes[current_mode]):upper()
-- end
--
-- function M.get_mode()
--     local mode_code = vim.api.nvim_get_mode().mode
--     local mode = mode_map[mode_code] or string.upper(mode_code)
--     return "%#Mode" .. mode:sub(1, 1) .. "# " .. mode .. " %*"
-- end
--
-- function M.get_lines()
--     return tostring(vim.api.nvim_win_get_cursor(0)[1]) .. "/" .. tostring(vim.api.nvim_buf_line_count(0))
-- end
--
-- function M.statusline()
--     local parts = {
--         [[%<» %{luaeval("require'bemu.statusline.statusline'.get_mode()")} %=]],
--         [[%<» %{luaeval("require'bemu.statusline.statusline'.get_lines()")} %=]],
--     }
--     return table.concat(parts, "")
-- end
--
-- return M
local M = {}

local api = vim.api

local function highlight(num, active)
  if active == 1 then
    if num == 1 then
      return '%#PmenuSel#'
    else
      return '%#StatusLine#'
    end
  else
    return '%#StatusLineNC#'
  end
end

local function hldefs()
  local bg = api.nvim_get_hl_by_name('StatusLine', true).background
  for _, ty in ipairs { 'Warn', 'Error', 'Info', 'Hint' } do
    local hl = api.nvim_get_hl_by_name('Diagnostic' .. ty, true)
    local name = ('Diagnostic%sStatus'):format(ty)
    api.nvim_set_hl(0, name, { fg = hl.foreground, bg = bg })
  end
end

local icons = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = 'I',
}

function M.get_mode()
  local mode_code = vim.api.nvim_get_mode().mode
  local mode = mode_map[mode_code] or string.upper(mode_code)
  return '%#Mode' .. mode:sub(1, 1) .. '# ' .. mode .. ' %*'
end

function M.lsp_status(active)
  local status = {}

  for _, ty in ipairs { 'Error', 'Warn', 'Info', 'Hint' } do
    local n = vim.diagnostic.get(0, { severity = ty })
    if #n > 0 then
      local icon = icons[ty]
      if active == 1 then
        table.insert(status, ('%%#Diagnostic%sStatus#%s %s'):format(ty, icon, #n))
      else
        table.insert(status, ('%s %s'):format(icon, #n))
      end
    end
  end

  if vim.g.metals_status then
    status[#status + 1] = vim.g.metals_status:gsub('%%', '%%%%')
  end

  local r = table.concat(status, ' ')

  return r == '' and 'LSP' or r
end

function M.hunks()
  if vim.b.gitsigns_status then
    local status = vim.b.gitsigns_head
    if vim.b.gitsigns_status ~= '' then
      status = status .. ' ' .. vim.b.gitsigns_status
    end
    return status
  elseif vim.g.gitsigns_head then
    return vim.g.gitsigns_head
  end
  return ''
end

function M.blame()
  if vim.b.gitsigns_blame_line_dict then
    local info = vim.b.gitsigns_blame_line_dict
    local date_time = require('gitsigns.util').get_relative_time(tonumber(info.author_time))
    return string.format('%s - %s', info.author, date_time)
  end
  return ''
end

local function filetype_symbol()
  do
    return ''
  end
  local res = vim.F.npcall(api.nvim_call_function, 'WebDevIconsGetFileTypeSymbol', {})
  if res then
    return res
  end
  local devicons = vim.F.npcall(require, 'nvim-web-devicons')
  if devicons then
    local name = api.nvim_buf_get_name(0)
    return devicons.get_icon(name, vim.bo.filetype, { default = true })
  end
  return ''
end

local function is_treesitter()
  local bufnr = api.nvim_get_current_buf()
  return vim.treesitter.highlighter.active[bufnr] ~= nil
end

function M.filetype()
  return table.concat({
    vim.bo.filetype,
    filetype_symbol(),
    -- Causes artifacts in ruler section
    -- is_treesitter() and '🌴' or nil
    is_treesitter() and '' or nil,
  }, ' ')
end

function M.encodingAndFormat()
  local e = vim.bo.fileencoding and vim.bo.fileencoding or vim.o.encoding

  local r = {}
  if e ~= 'utf-8' then
    r[#r + 1] = e
  end

  local f = vim.bo.fileformat
  if f ~= 'unix' then
    r[#r + 1] = '[' .. f .. ']'
    local ok, res = pcall(api.nvim_call_function, 'WebDevIconsGetFileFormatSymbol')
    if ok then
      r[#r + 1] = res
    end
  end

  return table.concat(r, ' ')
end

local function recording()
  local reg = vim.fn.reg_recording()
  if reg ~= '' then
    return '%#ModeMsg#  RECORDING[' .. reg .. ']  '
  else
    return ''
  end
end

function M.bufname()
  ---@diagnostic disable-next-line: undefined-field
  local name = vim.api.nvim_eval_statusline('%f', {}).str
  local buf_name = vim.api.nvim_buf_get_name(0)
  if vim.startswith(buf_name, 'fugitive://') then
    local _, _, commit, relpath = buf_name:find [[^fugitive://.*/%.git.*/(%x-)/(.*)]]
    name = relpath .. '@' .. commit:sub(1, 7)
  end
  if vim.startswith(buf_name, 'gitsigns://') then
    local _, _, revision, relpath = buf_name:find [[^gitsigns://.*/%.git.*/(.*):(.*)]]
    name = relpath .. '@' .. revision:sub(1, 7)
  end

  return name
end

local function pad(x)
  return '%( ' .. x .. ' %)'
end

local function func(name, active, mods)
  active = active or 1
  return '%' .. (mods or '') .. '{%v:lua.statusline.' .. name .. '(' .. tostring(active) .. ')%}'
end

local function parse_sections(sections)
  local result = {}
  for _, s in ipairs(sections) do
    local sub_result = {}
    for _, part in ipairs(s) do
      sub_result[#sub_result + 1] = part
    end
    result[#result + 1] = table.concat(sub_result)
  end
  -- Leading '%=' reeded for first highlight to work
  return '%=' .. table.concat(result, '%=')
end

function M.set(active, global)
  local scope = global and 'o' or 'wo'
  vim[scope].statusline = parse_sections {
    {
      highlight(1, active),
      recording(),
      pad(func 'hunks'),
      highlight(2, active),
      pad(func('lsp_status', active)),
      highlight(2, active),
    },
    {
      '%<',
      pad(func('bufname', nil, '0.60') .. '%m%r%h%q'),
    },
    {
      pad(func 'filetype'),
      pad(func 'encodingAndFormat'),
      highlight(1, active),
      ' %3p%% %2l(%02c)/%-3L ', -- 80% 65[12]/120
    },
  }
end

-- Only set up WinEnter autocmd when the WinLeave autocmd runs
api.nvim_create_augroup('statusline', {})
api.nvim_create_autocmd({ 'WinLeave', 'FocusLost' }, {
  group = 'statusline',
  callback = function()
    api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter', 'FocusGained' }, {
      group = 'statusline',
      callback = function()
        M.set(1)
      end,
    })
    M.set(0)
  end,
})

api.nvim_create_autocmd('VimEnter', {
  group = 'statusline',
  callback = function()
    M.set(1, true)
  end,
})

api.nvim_create_autocmd('ColorScheme', {
  group = 'statusline',
  callback = hldefs,
})

_G.statusline = M

return M

-- more simple version based on https://www.reddit.com/r/neovim/comments/1jbzvtb/i_learned_how_to_customize_the_statusline/
-- function update_statusline()
--   vim.system({ 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }, { text = true }, function(res)
--     vim.schedule(function()
--       -- there should be here a "branch" icon but reddit doesn't render it
--       local branch = ' ' .. vim.trim(res.stdout)
--
--       vim.o.statusline = " %f %{&modified?'●':''} " .. branch .. '%=at %c | %L lines | %%%p '
--
--       vim.cmd 'redrawstatus'
--     end
--     )
--   end)
-- end
--
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'ShellCmdPost' }, {
--
--   pattern = '*',
--
--   callback = function()
--     local filename = vim.fn.bufname '%'
--
--     local buftype = vim.bo.buftype
--
--     -- local is\_file\_valid = vim.fn.filereadable(filename)
--
--     if filename == '' or buftype ~= '' then
--       vim.schedule(function()
--         vim.opt_local.statusline = ' '
--       end)
--     else
--       update_statusline()
--     end
--   end,
-- })
--
-- vim.o.statusline = " %f %{&modified?'●':''}%=at %c | %L lines | %%%p "
