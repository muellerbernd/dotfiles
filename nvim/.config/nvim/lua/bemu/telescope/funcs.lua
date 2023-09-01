local M = {}

-- local sorters = require "telescope.sorters"
local themes = require 'telescope.themes'
-- local previewers = require "telescope.previewers"
function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = '~ dotfiles ~',
    shorten_path = false,
    cwd = '~/.config/nvim',

    -- layout_strategy = 'horizontal',
    -- layout_config = {preview_width = 0.65}
  }
end

function M.find_nvim_source()
  require('telescope.builtin').find_files {
    prompt_title = '~ nvim ~',
    shorten_path = false,
    cwd = '~/build/neovim/',
    width = 0.25,

    -- layout_strategy = 'horizontal',
    -- layout_config = {preview_width = 0.65}
  }
end

function M.edit_zsh()
  require('telescope.builtin').find_files {
    shorten_path = false,
    cwd = '~/.config/zsh/',
    prompt = '~ dotfiles ~',
    hidden = true,

    -- layout_strategy = 'horizontal',
    -- layout_config = {preview_width = 0.55}
  }
end

function M.local_plugins()
  require('telescope.builtin').find_files {
    shorten_path = false,
    -- cwd = "~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/nvim_plugins/",
    cwd = '~/Desktop/GithubProjects/nvim-plugins/',
    prompt = '~ local plugins ~',
    -- hidden = true,
    -- layout_strategy = 'horizontal',
    -- layout_config = {preview_width = 0.55}
  }
end

function M.fd()
  require('telescope.builtin').fd()
end

function M.builtin()
  require('telescope.builtin').builtin()
end

function M.git_files()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').git_files(opts)
end

function M.buffer_git_files()
  require('telescope.builtin').git_files(themes.get_dropdown {
    cwd = vim.fn.expand '%:p:h',
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.lsp_set_loclist()
  local opts = {
    -- winblend = 10,
    -- border = true,
    -- previewer = false,
    -- shorten_path = false,
    bufnr = 0,
  }
  -- _ = vim.lsp.diagnostic.set_qflist()
  -- require('telescope.builtin').quickfix(opts)
  require('telescope.builtin').diagnostics(opts)
end

function M.lsp_references()
  require('telescope.builtin').lsp_references {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    ignore_filename = false,
  }
end

function M.lsp_implementations()
  require('telescope.builtin').lsp_implementations {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    ignore_filename = false,
  }
end

function M.vim_options()
  require('telescope.builtin').vim_options {
    layout_config = {
      width = 0.5,
    },
    sorting_strategy = 'ascending',
  }
end

function M.live_grep()
  local opts = {
    -- cwd = vim.loop.cwd()
    cwd = vim.fn.expand '%:p:h',
  }
  require('telescope.builtin').live_grep(opts)
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    shorten_path = true,
    search = vim.fn.input 'Grep String > ',
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', ''):gsub('\\C', '')

  opts.shorten_path = true
  opts.word_match = '-w'
  opts.search = register

  require('telescope.builtin').grep_string(opts)
end

function M.oldfiles()
  if true then
    require('telescope').extensions.frecency.frecency()
  end
  if pcall(require('telescope').load_extension, 'frecency') then
  else
    require('telescope.builtin').oldfiles { layout_strategy = 'vertical' }
  end
end

function M.my_plugins()
  require('telescope.builtin').find_files { cwd = '~/plugins/' }
end

function M.installed_plugins()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath 'data' .. '/site/pack/packer/start/',
  }
end

function M.project_search()
  require('telescope.builtin').find_files {
    previewer = false,
    layout_strategy = 'vertical',
    cwd = require('nvim_lsp.util').root_pattern '.git'(vim.fn.expand '%:p'),
  }
end

function M.buffers()
  require('telescope.builtin').buffers { shorten_path = false }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,

    -- layout_strategy = 'current_buffer',
  }
  require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require('telescope.builtin').help_tags { show_version = true }
end

function M.search_all_files()
  require('telescope.builtin').find_files {
    find_command = { 'rg', '--no-ignore', '--files' },
  }
end

-- function M.file_browser()
--   local opts
--
--   opts = {
--     sorting_strategy = "ascending",
--     scroll_strategy = "cycle",
--     layout_config = {
--       prompt_position = "top",
--     },
--
--     attach_mappings = function(prompt_bufnr, map)
--       local current_picker = action_state.get_current_picker(prompt_bufnr)
--
--       local modify_cwd = function(new_cwd)
--         local finder = current_picker.finder
--
--         finder.path = new_cwd
--         finder.files = true
--         current_picker:refresh(false, { reset_prompt = true })
--       end
--
--       map("i", "-", function()
--         modify_cwd(current_picker.cwd .. "/..")
--       end)
--
--       map("i", "~", function()
--         modify_cwd(vim.fn.expand "~")
--       end)
--
--       -- local modify_depth = function(mod)
--       --   return function()
--       --     opts.depth = opts.depth + mod
--       --
--       --     current_picker:refresh(false, { reset_prompt = true })
--       --   end
--       -- end
--       --
--       -- map("i", "<M-=>", modify_depth(1))
--       -- map("i", "<M-+>", modify_depth(-1))
--
--       map("n", "yy", function()
--         local entry = action_state.get_selected_entry()
--         vim.fn.setreg("+", entry.value)
--       end)
--
--       return true
--     end,
--   }
--
--   require("telescope").extensions.file_browser.file_browser(opts)
-- end

function M.file_browser()
  local opts = {
    path = '%:p:h',
    select_buffer = true,
    respect_gitignore = false,
    hidden = false,
  }

  require('telescope').extensions.file_browser.file_browser(opts)
end

function M.list_vimwikis()
  local opts = { cwd_to_path = true, path = '%:p:h' }

  require('telescope').extensions.list_vimwikis.list_vimwikis(opts)
end

function M.list_mywikis()
  local opts = { cwd_to_path = true, path = '%:p:h' }

  require('telescope').extensions.list_wikis.list_wikis(opts)
end

function M.treesitter()
  local opts = { bufnr = 0 }
  require('telescope.builtin').treesitter(opts)
end

function M.current_buffer_tags()
  local opts = { sorting_strategy = 'ascending' }
  vim.cmd '!ctags -R'
  -- inspired by https://vi.stackexchange.com/questions/33188/sorting-taglist-output-by-order-of-appearance-in-the-file
  --     function TagsInCurrentBuffer() abort
  --   let current_filename = expand('%:p')
  --
  --   let taglist_for_buffer = filter(
  --       \taglist('.'),
  --       \ { idx, val -> fnamemodify(val.filename, 'p') == current_filename })
  --
  --   if len(taglist_for_buffer)==0
  --       return []
  --   endif
  --
  --   let tags_by_line = {}
  --
  --   for tag_dict in taglist_for_buffer
  --       " Trim off starting and ending '/' characters from cmd
  --       let cmd  = tag_dict['cmd'][1:-2]
  --       let name = tag_dict['name']
  --       let line_num = searchpos(cmd,'n')[0]
  --       let tags_by_line[line_num] = name
  --   endfor
  --
  --   let sorted_tags = []
  --   " Sort strings numerically with the 'N' flag
  --   for line_num in sort(keys(tags_by_line),'N')
  --       call add(sorted_tags, tags_by_line[line_num])
  --   endfor
  --
  --   return sorted_tags
  --
  -- endfunction
  require('telescope.builtin').current_buffer_tags(opts)
end

function M.reload()
  -- Telescope will give us something like ju/colors.lua,
  -- so this function convert the selected entry to
  -- the module name: ju.colors
  local function get_module_name(s)
    local module_name

    module_name = s:gsub('%.lua', '')
    module_name = module_name:gsub('%/', '.')
    module_name = module_name:gsub('%.init', '')

    return module_name
  end

  local prompt_title = '~ neovim modules ~'

  -- sets the path to the lua folder
  local path = '~/.config/nvim/lua'

  local opts = {
    prompt_title = prompt_title,
    cwd = path,
    -- file_sorter = require("telescope.sorters").fuzzy_with_index_bias,

    -- find_command={'rg','--files','--sortr','modified'},
    find_command = {
      'fd',
      '--type',
      'f',
      '--exec-batch',
      'ls',
      '-t',
    },

    attach_mappings = function(_, map)
      -- Adds a new map to ctrl+e.
      map('i', '<cr>', function(_)
        -- these two a very self-explanatory
        local entry = require('telescope.actions.state').get_selected_entry()
        local name = get_module_name(entry.value)

        -- call the helper method to reload the module
        -- and give some feedback
        R(name)
        P(name .. ' RELOADED!!!')
      end)

      return true
    end,
  }

  -- call the builtin method to list files
  require('telescope.builtin').find_files(opts)
end

return M
