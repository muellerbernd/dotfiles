-- -- indent-blankline character.
-- local indent_blankline_style = 1
--
-- local indent_blankline_styles = {"│", "¦", "┆", "▏", "⎸", "|"}
--
-- vim.g.indent_blankline_char = indent_blankline_styles[indent_blankline_style]
-- vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
-- -- Disable indent-blankline on these pages.
-- vim.g.indent_blankline_filetype_exclude = {
--     "help", "startify", "alpha", "dashboard", "packer", "neogitstatus",
--     "NvimTree", "Trouble", "norg"
-- }
-- vim.g.indent_blankline_buftype_exclude = {"terminal"}
-- vim.g.indent_blankline_context_patterns = {
--     "class", "function", "method", "^if", "^case", "^while", "^use", "^for",
--     "class", "function", "func_literal", "method", "^if", "while", "for",
--     "with", "try", "except", "argument_list", "object", "dictionary", "element",
--     "table", "tuple"
--
-- }
--
-- vim.g.indent_blankline_show_current_context = true
-- vim.g.indent_blankline_show_current_context_start = false
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_first_indent_level = false
-- require("indent_blankline").setup({
--     -- for example, context is off by default, use this to turn it on
--     show_current_context = true,
--     show_current_context_start = true,
-- })

require('indent_blankline').setup {
  viewport_buffer = 100,
  char = '│',
  filetype_exclude = {
    'vimwiki',
    'man',
    'gitmessengerpopup',
    'diagnosticpopup',
    'lspinfo',
    'packer',
    'checkhealth',
    'TelescopePrompt',
    'TelescopeResults',
    'alpha',
    'dashboard',
    '',
  },
  buftype_exclude = { 'terminal' },
  space_char_blankline = ' ',
  show_foldtext = false,
  strict_tabs = true,
  debug = true,
  disable_with_nolist = true,
  max_indent_increase = 1,
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter_scope = true,
}
