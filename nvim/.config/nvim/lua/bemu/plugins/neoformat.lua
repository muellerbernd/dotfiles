-- vim.cmd([[
-- augroup fmt
--   autocmd!
--   autocmd BufWritePre * Neoformat
-- augroup END
-- ]])

-- Enable alignment
vim.g.neoformat_basic_format_align = 1

-- Enable tab to spaces conversion
vim.g.neoformat_basic_format_retab = 1

-- Enable trimmming of trailing whitespace
vim.g.neoformat_basic_format_trim = 1

-- run all formatters
vim.g.neoformat_run_all_formatters = 0
-- Have Neoformat only msg when there is an error
-- vim.g.neoformat_only_msg_on_error = 1
--
vim.g.neoformat_enabled_python = { 'black' }
vim.g.neoformat_enabled_rust = { 'rustfmt' }
vim.g.neoformat_enabled_lua = { 'stylua' }
vim.g.neoformat_enabled_yaml = { 'prettier' }
vim.g.neoformat_enabled_html = { 'tidy' }
-- vim.g.neoformat_enabled_handlebars = {}
vim.g.neoformat_enabled_xml = { 'tidy' }
vim.g.neoformat_enabled_shell = { 'shfmt' }
vim.g.neoformat_enabled_haskell = { 'ormolu' }
vim.g.neoformat_enabled_markdown = { 'prettier' }
