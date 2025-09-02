return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/Sync/orgfiles/**/*.org',
      org_default_notes_file = '~/Sync/orgfiles/refile.org',
    })
  end,
}
