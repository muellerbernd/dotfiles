local Job = require 'plenary.job'
-- local Path = require "plenary.path"

local zathura = {}
local enable_autocmd = false

local replace_extension = function(path, ext)
  local offset
  for i = #path, 1, -1 do
    if path:sub(i, i) == '.' then
      offset = i
      break
    end
  end
  return path:sub(1, offset) .. ext
end

vim.api.nvim_create_augroup('Typst', { clear = true })

local bufnr = vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'Typst',
  buffer = bufnr,
  callback = function()
    if enable_autocmd then
      local abs_path = vim.api.nvim_buf_get_name(bufnr)
      local pdf_path = replace_extension(abs_path, 'pdf')
      local typstmake = Job:new {
        command = 'typst',
        args = {
          'compile',
          abs_path,
          -- pdf_path,
        },
        on_stdout = function(j, return_val)
          print(return_val)
        end,
      }
      typstmake:after_success(function()
        if zathura[bufnr] == nil then
          zathura[bufnr] = Job:new { command = 'zathura', args = { pdf_path } }
          zathura[bufnr]:start()
        end
      end)
      typstmake:start()
    end
  end,
})

vim.keymap.set('n', '<leader>ll', function()
  enable_autocmd = not enable_autocmd
  local status = enable_autocmd and 'enabled' or 'disabled'
  vim.notify(string.format('Typst %s!', status), vim.log.levels.INFO)
end, { desc = 'toggle typst pdf building' })

-- set tab width to 2
local o = vim.opt_local

o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
