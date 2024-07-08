local Job = require 'plenary.job'
-- local Path = require "plenary.path"

local zathura = {}
local enable_typst_autocmd = false

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

vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('Typst', { clear = true }),
  -- buffer = bufnr,
  pattern = 'main*',
  callback = function()
    if enable_typst_autocmd then
      -- local bufnr = vim.api.nvim_get_current_buf()
      -- local abs_path = vim.api.nvim_buf_get_name(bufnr)
      -- vim.notify(string.format('typst compile %s!', abs_path), vim.log.levels.INFO)

      local abs_path = vim.api.nvim_buf_get_name(bufnr)
      local pdf_path = replace_extension(abs_path, 'pdf')
      local typstmake = Job:new {
        command = 'typst',
        args = {
          'compile',
          abs_path,
        },
        on_stdout = function(j, return_val)
          vim.notify(string.format('retval %s!', return_val), vim.log.levels.INFO)
          vim.notify(string.format('j %s!', j), vim.log.levels.INFO)
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
  enable_typst_autocmd = not enable_typst_autocmd
  local status = enable_typst_autocmd and 'enabled' or 'disabled'
  vim.notify(string.format('Typst %s!', status), vim.log.levels.INFO)
end, { desc = 'toggle typst pdf building' })

-- set tab width to 2
local o = vim.opt_local

o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
