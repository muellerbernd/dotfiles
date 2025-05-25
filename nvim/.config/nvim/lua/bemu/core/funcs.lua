local custom_funcs = {}
local playSound = false
local trimWhitespace = true

custom_funcs.PlaySaveSound = function()
  if playSound then
    vim.fn.jobstart 'play ~/.config/nvim/support/General_Saving.wav'
  end
end

custom_funcs.PlayLeaveSound = function()
  if playSound then
    -- vim.api.nvim_command("AsyncRun -silent play ~/.config/nvim/support/ohNein.wav")
    vim.fn.jobstart 'screen -m -d play ~/.config/nvim/support/ohNein.wav'
  end
end

custom_funcs.TogglePlaySound = function()
  playSound = not playSound
  print('Custom sounds ' .. tostring(playSound))
end

custom_funcs.ToggleTrimWhitespace = function()
  trimWhitespace = not trimWhitespace
  print('TrimWhitespace ' .. tostring(trimWhitespace))
end

-- custom_funcs.VimReload = function()
--   -- vim.api.nvim_exec("luafile %", false)
--   vim.api.nvim_exec('so ~/.config/nvim/init.lua', false)
--   vim.notify 'Reloaded nvim config'
-- end

custom_funcs.reload_nvim_conf = function()
  for name, _ in pairs(package.loaded) do
    if name:match '^core' or name:match '^lsp' or name:match '^plugins' then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end

custom_funcs.TrimWhitespace = function()
  if trimWhitespace then
    local save = vim.fn.winsaveview()
    vim.api.nvim_exec2('keepjumps keeppatterns silent! %s/\\s\\+$//e', {})
    vim.fn.winrestview(save)
  end
end

custom_funcs.retab = function()
  if trimWhitespace then
    local save = vim.fn.winsaveview()
    vim.api.nvim_exec2('retab', {})
    vim.fn.winrestview(save)
  end
end

custom_funcs.ToggleWord = function()
  local word = vim.fn.expand '<cword>'

  local word_mapping = {
    ['true'] = 'false',
    ['True'] = 'False',
    ['yes'] = 'no',
    ['on'] = 'off',
    ['ON'] = 'OFF',
  }

  -- add reversed key value pairs to table
  for k, v in pairs(word_mapping) do
    word_mapping[v] = k
  end

  local new_word = word_mapping[word] or word

  vim.cmd('normal ciw' .. new_word)
end

custom_funcs.ToggleCase = function()
  -- expand('<cword>') to get the current word under cursor
  local current_word = vim.call('expand', '<cword>')
  local function toggle_case_v2(str)
    if str:match '_' then
      -- Convert snake_case (including uppercase letters) to camelCase
      return (str
        :gsub('_(%u)', function(c)
          return c
        end)
        :gsub('_(%l)', function(c)
          return c:upper()
        end)):gsub('^(%l)', string.upper)
    else
      -- Convert camelCase to snake_case, while preserving the first character
      return (str:gsub('(%u)', '_%1')):lower():gsub('^_', '')
    end
  end
  local new_word = toggle_case_v2(current_word)
  vim.cmd('normal! ciw' .. new_word)
end

-- https://www.rockyourcode.com/vim-create-a-directory/
custom_funcs.MkNonExDir = function()
  -- local dir = vim.fn.fnamemodify(newfilepath, ':h')
  -- print(dir)
  local dir = vim.call('expand', '%:p:h')
  if vim.fn.isdirectory(dir) ~= 1 then
    vim.fn.mkdir(dir, 'p')
  end
end

custom_funcs.goto_file = function()
  -- expand('<cfile>') to get the current file under cursor
  local current_file = vim.call('expand', '<cfile>')
  local newfilepath = vim.call('expand', '%:p:h') .. '/' .. current_file
  if vim.fn.filereadable(vim.fn.expand(newfilepath)) == 1 then
    print 'file exists'
    vim.cmd 'normal gf'
  else
    print 'file does not exist'
    vim.api.nvim_exec2('edit' .. newfilepath, {})
  end
end

custom_funcs.vert_term = function()
  local win_width = vim.fn.winwidth(0)
  local term_width = win_width / 3
  vim.api.nvim_exec2(term_width .. 'vs | term', {})
end

custom_funcs.horiz_term = function()
  local win_height = vim.fn.winheight(0)
  local term_height = win_height / 4
  vim.api.nvim_exec2('bel' .. term_height .. 'sp | term', {})
end

custom_funcs.update_markdown_date = function()
  local current_date = os.date '%Y-%m-%dT%H:%M:%S%z'
  -- Add the colon in the timezone
  current_date = current_date:sub(1, -3) .. ':' .. current_date:sub(-2)
  vim.cmd('%s/\\(date = \\)\\(.*\\)/\\1' .. current_date .. '/')
end

return custom_funcs
