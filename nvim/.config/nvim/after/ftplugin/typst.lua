local enable_autocmd = false

vim.api.nvim_create_augroup('Typst', { clear = true })

local zathura = {}
local bufnr = vim.api.nvim_get_current_buf()
local abs_path = vim.api.nvim_buf_get_name(bufnr)
if not abs_path or abs_path == '' then
  return
end

vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'Typst',
  pattern = '*.typ',
  callback = function()
    -- Skip template.typ specifically
    local fname = vim.fn.fnamemodify(abs_path, ':t')
    if fname == 'template.typ' then
      return
    end
    local function replace_extension(path, ext)
      local offset
      for i = #path, 1, -1 do
        if path:sub(i, i) == '.' then
          offset = i
          break
        end
      end
      return path:sub(1, offset) .. ext
    end

    local pdf_path = replace_extension(abs_path, 'pdf')
    if enable_autocmd then
      local on_exit = function(obj)
        if obj.code == 0 then
          if zathura[abs_path] == nil and pdf_path then
            zathura[abs_path] = vim.system({ 'zathura', pdf_path }, { text = true })
          end
        end
      end
      vim.system({ 'typst', 'compile', abs_path }, { text = true }, on_exit)
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufWipeout', 'BufDelete', 'ExitPre' }, {
  group = 'Typst',
  pattern = '*.typ',
  callback = function()
    zathura[abs_path]:kill 'sigterm'
    zathura[abs_path] = nil
  end,
})

vim.keymap.set('n', '<leader>ll', function()
  enable_autocmd = not enable_autocmd
  local status = enable_autocmd and 'enabled' or 'disabled'
  vim.notify(string.format('Typst %s!', status), vim.log.levels.INFO)
end, { desc = 'toggle typst pdf building' })

-- buffer-local style options
vim.opt_local.expandtab = true
vim.opt_local.smartindent = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
