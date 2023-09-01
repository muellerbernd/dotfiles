-- local present, vimwiki = pcall(require, "vimwiki")
-- if not present then
--     return
-- end
-- local is_loaded = false
-- if packer_plugins["vimwiki"] and packer_plugins["vimwiki"].loaded then
--     is_loaded = true
-- end
--
-- if not is_loaded then
--     return
-- end

-- vimwiki stuff
-- Run multiple wikis
vim.g.vimwiki_list = {
  {
    path = '/home/bernd/Desktop/Nextcloud/vimwiki',
    -- syntax = "markdown",
    -- ext = ".md",
  },
  {
    path = '/home/bernd/Desktop/Nextcloud/vimwiki-md',
    syntax = 'markdown',
    ext = '.md',
  },
  {
    path = '/home/bernd/Desktop/GitProjects/IOSB-WORK/wiki',
    syntax = 'markdown',
    ext = '.md',
  },
  -- {
  --  path = "/home/bernd/Desktop/GitProjects/Fachpraktikum-IOSB-AST/wiki",
  --  -- syntax = 'markdown',
  --  -- ext = '.md'
  -- },
  {
    path = '/home/bernd/Desktop/GitProjects/MA-Thesis/wiki',
    -- syntax = 'markdown',
    -- ext = '.md'
  },
}
vim.g.vimwiki_ext2syntax = { ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown' }
vim.g.vimwiki_global_ext = 0
-- wiki_prime = {
--     auto_diary_index = 1,
--     auto_generate_links = 1,
--     auto_generate_tags = 1,
--     auto_tags = 1,
--     auto_toc = 1,
--     automatic_nested_syntaxes = 1,
--     diary_caption_level = 2,
--     list_margin = 0,
--     name = 'prime',
--     nested_syntaxes = {
--       python = "python",
--       lua = "lua"
--     },
--     path = '~/Documents/Vimwiki/',
--     syntax = 'markdown',
--     ext = '.md'
-- }
-- vim.g.vimwiki_auto_header = 1
-- vim.g.vimwiki_conceal_onechar_markers = 1
-- vim.g.vimwiki_dir_link = 'index'
-- vim.g.vimwiki_folding = 'expr'
-- vim.g.vimwiki_use_calendar = 0
-- vim.g.vimwiki_global_ext = 0
-- disable concealing
vim.g.vimwiki_conceallevel = 0
