-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  print 'npairs not ok'
  return
end

npairs.setup {
  disable_filetype = { 'TelescopePrompt', 'spectre_panel', 'vim' },
  -- fast_wrap = {
  --     map = "<M-e>",
  --     chars = { "{", "[", "(", '"', "'" },
  --     pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
  --     offset = 0, -- Offset from pattern match
  --     end_key = "$",
  --     keys = "qwertyuiopzxcvbnmasdfghjkl",
  --     check_comma = true,
  --     highlight = "PmenuSel",
  --     highlight_grey = "LineNr",
  -- },
  disable_in_macro = false, -- disable when recording or executing a macro
  disable_in_visualblock = false, -- disable when insert after visual block mode
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
  enable_moveright = true,
  enable_afterquote = true, -- add bracket pairs after quote
  enable_check_bracket_line = true, --- check bracket in same line
  enable_bracket_in_quote = true, --
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    -- javascript = {"string", "template_string"},
    -- java = false
  },
  map_cr = true,
  map_bs = true, -- map the <BS> key
  map_c_h = false, -- Map the <C-h> key to delete a pair
  map_c_w = false, -- map <c-w> to delete a pair if possible
}

-- you can use some built-in conditions

local Rule = require 'nvim-autopairs.rule'

npairs.add_rule(Rule('$', '$', 'tex'))

-- you can use some built-in conditions

local cond = require 'nvim-autopairs.conds'
-- stylua: ignore start
-- npairs.add_rules({
--   Rule("$", "$",{"tex", "latex"})
--     -- don't add a pair if the next character is %
--     :with_pair(cond.not_after_regex("%%"))
--     -- don't add a pair if  the previous character is xxx
--     -- :with_pair(cond.not_before_regex("xxx", 3))
--     -- don't move right when repeat character
--     :with_move(cond.none())
--     -- don't delete if the next character is xx
--     -- :with_del(cond.not_after_regex("xx"))
--     -- disable adding a newline when you press <cr>
--     :with_cr(cond.none())
--   },
--   -- disable for .vim files, but it work for another filetypes
--   Rule("a","a","-vim")
-- )

-- stylua: ignore end

local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
