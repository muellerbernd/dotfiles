if not pcall(require, 'telescope') then
  return
end

local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD 'plenary'
    RELOAD 'popup'
    RELOAD 'telescope'
  end
end

reloader()

local actions = require 'telescope.actions'
local sorters = require 'telescope.sorters'
local themes = require 'telescope.themes'
local previewers = require 'telescope.previewers'
-- local trouble = require("trouble.providers.telescope")
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--no-ignore',
    },
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    -- initial_mode = "insert",
    initial_mode = 'normal',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'vertical',
    layout_config = {
      height = 0.90,
      prompt_position = 'top',
      preview_height = 15,
    },
    -- winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    -- file_previewer = previewers.vim_buffer_cat.new,
    -- grep_previewer = previewers.vim_buffer_vimgrep.new,
    -- qflist_previewer = previewers.vim_buffer_qflist.new,
    dynamic_preview_title = true,
    -- path_display = {},
    path_display = { 'truncate' },
    -- path_display = { "smart" },
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,
        ['<ScrollWheelUp>'] = actions.preview_scrolling_up,
        ['<ScrollWheelDown>'] = actions.preview_scrolling_down,
      },
      n = {
        q = actions.close,
        ['<ScrollWheelUp>'] = actions.preview_scrolling_up,
        ['<ScrollWheelDown>'] = actions.preview_scrolling_down,
      },
    },
    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
  pickers = {
    grep_string = {
      -- only sort top 50 entries
      temp__scrolling_limit = 50,
    },
    find_files = {
      find_command = {
        'fd',
        '--type',
        'f',
        '--strip-cwd-prefix',
        '-E',
        '*cache*',
      },
      cwd = vim.fn.expand '%:p:h',
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      cwd_to_path = true,
      grouped = true,
      select_buffer = true,
      respect_gitignore = false,
      hidden = false,
    },
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- Load the fzy native extension at the start.
pcall(require('telescope').load_extension, 'fzy_native')
-- To get telescope-file-browser loaded
pcall(require('telescope').load_extension, 'file_browser')
-- pcall(require('telescope').load_extension, "gh")
-- pcall(require("telescope").load_extension, "cheat")
-- pcall(require("telescope").load_extension, "dap")
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
pcall(require('telescope').load_extension, 'ui-select')

-- pcall(require("telescope").load_extension, "asynctasks")

-- local M = {}
--
-- --[[
-- lua require('plenary.reload').reload_module("my_user.tele")
-- nnoremap <leader>en <cmd>lua require('my_user.tele').edit_neovim()<CR>
-- --]]
-- function M.edit_neovim()
--     require("telescope.builtin").find_files({
--         prompt_title = "~ dotfiles ~",
--         shorten_path = false,
--         cwd = "~/.config/nvim",
--
--         -- layout_strategy = 'horizontal',
--         -- layout_config = {preview_width = 0.65}
--     })
-- end
--
-- function M.find_nvim_source()
--     require("telescope.builtin").find_files({
--         prompt_title = "~ nvim ~",
--         shorten_path = false,
--         cwd = "~/build/neovim/",
--         width = 0.25,
--
--         -- layout_strategy = 'horizontal',
--         -- layout_config = {preview_width = 0.65}
--     })
-- end
--
-- function M.edit_zsh()
--     require("telescope.builtin").find_files({
--         shorten_path = false,
--         cwd = "~/.config/zsh/",
--         prompt = "~ dotfiles ~",
--         hidden = true,
--
--         -- layout_strategy = 'horizontal',
--         -- layout_config = {preview_width = 0.55}
--     })
-- end
--
-- function M.local_plugins()
--     require("telescope.builtin").find_files({
--         shorten_path = false,
--         -- cwd = "~/Desktop/GitProjects/UsefulConfigs/berndsConfigs/nvim_plugins/",
--         cwd = "~/Desktop/GithubProjects/nvim-plugins/",
--         prompt = "~ local plugins ~",
--         -- hidden = true,
--         -- layout_strategy = 'horizontal',
--         -- layout_config = {preview_width = 0.55}
--     })
-- end
--
-- function M.fd()
--     require("telescope.builtin").fd()
-- end
--
-- function M.builtin()
--     require("telescope.builtin").builtin()
-- end
--
-- function M.git_files()
--     local opts = themes.get_dropdown({
--         winblend = 10,
--         border = true,
--         previewer = false,
--         shorten_path = false,
--     })
--
--     require("telescope.builtin").git_files(opts)
-- end
--
-- function M.buffer_git_files()
--     require("telescope.builtin").git_files(themes.get_dropdown({
--         cwd = vim.fn.expand("%:p:h"),
--         winblend = 10,
--         border = true,
--         previewer = false,
--         shorten_path = false,
--     }))
-- end
--
-- function M.lsp_set_loclist()
--     local opts = {
--         -- winblend = 10,
--         -- border = true,
--         -- previewer = false,
--         -- shorten_path = false,
--         bufnr = 0,
--     }
--     -- _ = vim.lsp.diagnostic.set_qflist()
--     -- require('telescope.builtin').quickfix(opts)
--     require("telescope.builtin").diagnostics(opts)
-- end
--
-- function M.lsp_code_actions()
--     local opts = {}
--
--     require("telescope.builtin").lsp_incoming_calls(opts)
-- end
--
-- function M.live_grep()
--     local opts = {
--         -- cwd = vim.loop.cwd()
--         cwd = vim.fn.expand("%:p:h"),
--     }
--     require("telescope.builtin").live_grep(opts)
-- end
--
-- function M.grep_prompt()
--     require("telescope.builtin").grep_string({
--         shorten_path = true,
--         search = vim.fn.input("Grep String > "),
--     })
-- end
--
-- function M.grep_last_search(opts)
--     opts = opts or {}
--
--     -- \<getreg\>\C
--     -- -> Subs out the search things
--     local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")
--
--     opts.shorten_path = true
--     opts.word_match = "-w"
--     opts.search = register
--
--     require("telescope.builtin").grep_string(opts)
-- end
--
-- function M.oldfiles()
--     if true then
--         require("telescope").extensions.frecency.frecency()
--     end
--     if pcall(require("telescope").load_extension, "frecency") then
--     else
--         require("telescope.builtin").oldfiles({ layout_strategy = "vertical" })
--     end
-- end
--
-- function M.my_plugins()
--     require("telescope.builtin").find_files({ cwd = "~/plugins/" })
-- end
--
-- function M.installed_plugins()
--     require("telescope.builtin").find_files({
--         cwd = vim.fn.stdpath("data") .. "/site/pack/packer/start/",
--     })
-- end
--
-- function M.project_search()
--     require("telescope.builtin").find_files({
--         previewer = false,
--         layout_strategy = "vertical",
--         cwd = require("nvim_lsp.util").root_pattern(".git")(vim.fn.expand("%:p")),
--     })
-- end
--
-- function M.buffers()
--     require("telescope.builtin").buffers({ shorten_path = false })
-- end
--
-- function M.curbuf()
--     local opts = themes.get_dropdown({
--         winblend = 10,
--         border = true,
--         previewer = false,
--         shorten_path = false,
--
--         -- layout_strategy = 'current_buffer',
--     })
--     require("telescope.builtin").current_buffer_fuzzy_find(opts)
-- end
--
-- function M.help_tags()
--     require("telescope.builtin").help_tags({ show_version = true })
-- end
--
-- function M.search_all_files()
--     require("telescope.builtin").find_files({
--         find_command = { "rg", "--no-ignore", "--files" },
--     })
-- end
--
-- function M.file_browser()
--     local opts = {
--         -- select_buffer = true,
--         cwd_to_path = true,
--         grouped = true,
--         path = "%:p:h",
--         respect_gitignore = false,
--         hidden = false,
--     }
--
--     require("telescope").extensions.file_browser.file_browser(opts)
-- end
--
-- function M.list_vimwikis()
--     local opts = { cwd_to_path = true, path = "%:p:h" }
--
--     require("telescope").extensions.list_vimwikis.list_vimwikis(opts)
-- end
--
-- function M.list_mywikis()
--     local opts = { cwd_to_path = true, path = "%:p:h" }
--
--     require("telescope").extensions.list_wikis.list_wikis(opts)
-- end
--
-- function M.treesitter()
--     local opts = { bufnr = 0 }
--     require("telescope.builtin").treesitter(opts)
-- end
--
-- function M.reload()
--     -- Telescope will give us something like ju/colors.lua,
--     -- so this function convert the selected entry to
--     -- the module name: ju.colors
--     local function get_module_name(s)
--         local module_name
--
--         module_name = s:gsub("%.lua", "")
--         module_name = module_name:gsub("%/", ".")
--         module_name = module_name:gsub("%.init", "")
--
--         return module_name
--     end
--
--     local prompt_title = "~ neovim modules ~"
--
--     -- sets the path to the lua folder
--     local path = "~/.config/nvim/lua"
--
--     local opts = {
--         prompt_title = prompt_title,
--         cwd = path,
--         -- file_sorter = require("telescope.sorters").fuzzy_with_index_bias,
--
--         -- find_command={'rg','--files','--sortr','modified'},
--         find_command = {
--             "fd",
--             "--type",
--             "f",
--             "--exec-batch",
--             "ls",
--             "-t",
--         },
--
--         attach_mappings = function(_, map)
--             -- Adds a new map to ctrl+e.
--             map("i", "<cr>", function(_)
--                 -- these two a very self-explanatory
--                 local entry = require("telescope.actions.state").get_selected_entry()
--                 local name = get_module_name(entry.value)
--
--                 -- call the helper method to reload the module
--                 -- and give some feedback
--                 R(name)
--                 P(name .. " RELOADED!!!")
--             end)
--
--             return true
--         end,
--     }
--
--     -- call the builtin method to list files
--     require("telescope.builtin").find_files(opts)
-- end
--
-- return setmetatable({}, {
--     __index = function(_, k)
--         reloader()
--
--         if M[k] then
--             return M[k]
--         else
--             return require("telescope.builtin")[k]
--         end
--     end,
-- })
