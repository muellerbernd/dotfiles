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
