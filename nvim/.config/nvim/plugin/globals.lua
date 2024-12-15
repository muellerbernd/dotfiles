vim.tbl_add_reverse_lookup = function (tbl)
  for k, v in pairs(tbl) do
    tbl[v] = k
  end
end

-- vim.tbl_islist = function(tbl)
--   return vim.islist(tbl)
-- end

P = function(v)
  print(vim.inspect(v))
  vim.notify(string.format('%s!', v), vim.log.levels.INFO)
  -- return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
