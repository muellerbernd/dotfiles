local api = vim.api

Statusline = {}

local function filetype_symbol()
  local name = api.nvim_buf_get_name(0)
  local filetype = vim.bo.filetype
  -- print('Current file:', name, 'Filetype:', filetype) -- Debugging line

  local res = vim.F.npcall(api.nvim_call_function, 'WebDevIconsGetFileTypeSymbol', {})
  if res then
    return res
  end
  local devicons = vim.F.npcall(require, 'nvim-web-devicons')
  if devicons then
    local icon = devicons.get_icon(name, filetype, { default = true })
    -- print('Devicon result:', icon) -- Debugging line
    return icon
  end
  return ''
end

local function is_treesitter()
  local bufnr = api.nvim_get_current_buf()
  return vim.treesitter.highlighter.active[bufnr] ~= nil
end

-- Function to get the filetype icon
local function statusline_filetype()
  return table.concat({
    vim.bo.filetype,
    filetype_symbol(),
    -- Causes artifacts in ruler section
    -- is_treesitter() and '🌴' or nil
    is_treesitter() and '' or nil,
  }, ' ')
end

Statusline.active = function()
  local l = {}
  table.insert(l, ' ')
  table.insert(l, '%F') -- File name with path relative to current directory
  table.insert(l, '%M') -- Show modification flag if file is modified
  table.insert(l, ' %=') -- Left align the filename and right align everything after this
  table.insert(l, ' | ')
  table.insert(l, statusline_filetype()) -- File type icon
  table.insert(l, ' | ')
  table.insert(l, '%3p%% %2l[%02c]/%-3L') -- Line number and column
  table.insert(l, ' ')

  return table.concat(l)
end

function Statusline.inactive()
  return ' %F'
end

-- Only set up WinEnter autocmd when the WinLeave autocmd runs
api.nvim_create_augroup('statusline', {})

api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = 'statusline',
  callback = function()
    vim.opt.statusline = Statusline.active()
  end,
})
api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = 'statusline',
  callback = function()
    vim.opt.statusline = Statusline.inactive()
  end,
})
