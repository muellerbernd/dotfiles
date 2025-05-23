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

vim.api.nvim_create_augroup('Pandoc', { clear = true })

local bufnr = vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd('BufWritePost', {
  -- pattern = "*.md",
  group = 'Pandoc',
  buffer = bufnr,
  callback = function()
    if enable_autocmd then
      -- local bufnr = vim.api.nvim_get_current_buf()
      local abs_path = vim.api.nvim_buf_get_name(bufnr)
      local pdf_path = replace_extension(abs_path, 'pdf')
      local tex_path = replace_extension(abs_path, 'tex')
      local cwd = vim.fn.expand '%:p:h'
      local curr_line = vim.api.nvim_get_current_line()
      local texmake = Job:new {
        command = 'make',
        cwd = '/home/bernd/code-templates/pandoc/templates',
        -- cwd = cwd,
        args = {
          -- "-C",
          -- cwd,
          'build',
          string.format('abs_path=%s', abs_path),
          string.format('tex_path=%s', tex_path),
          string.format('root_path=%s', cwd),
        },
        on_stdout = function(j, return_val)
          -- Split return_val into lines
          local lines = vim.split(return_val, '\n')
          local new_entries = {}

          for _, line in ipairs(lines) do
            -- Create a quickfix entry for each line
            table.insert(new_entries, { text = line })
          end

          vim.schedule(function()
            -- Get the current quickfix list
            local current_qflist = vim.fn.getqflist()

            -- Append new entries to the existing quickfix list
            for _, entry in ipairs(new_entries) do
              table.insert(current_qflist, entry)
            end

            -- Set the updated quickfix list
            vim.fn.setqflist(current_qflist)
            -- Optionally open the quickfix window
            -- vim.cmd 'copen'
            -- Move the cursor to the last entry
            local count = #current_qflist
            if count > 0 then
              vim.fn.setqflist({}, 'r', { idx = count }) -- Focus the last entry
            end
          end)
        end,
        -- on_exit = function(j, return_val)
        --     if zathura[bufnr] == nil then
        --         zathura[bufnr] = Job:new { command = "zathura", args = { pdf_path } }
        --         zathura[bufnr]:start()
        --     end
        -- end,
      }
      texmake:after_success(function()
        if zathura[bufnr] == nil then
          -- zathura[bufnr] = Job:new { command = "zathura", args = { string.format("--find=%s", curr_line), pdf_path } }
          zathura[bufnr] = Job:new { command = 'zathura', args = { pdf_path } }
          zathura[bufnr]:start()
        end
      end)
      texmake:start()
    end
  end,
})

vim.keymap.set('n', '<leader>ll', function()
  enable_autocmd = not enable_autocmd
  local status = enable_autocmd and 'enabled' or 'disabled'
  vim.notify(string.format('Pandoc %s!', status), vim.log.levels.INFO)
end, { desc = 'toggle pandoc pdf building' })

-- set tab width to 2
local o = vim.opt_local

o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
