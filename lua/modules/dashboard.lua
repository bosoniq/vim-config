local db = require('dashboard')

db.setup({
    theme = 'hyper',
    shortcut_type = 'number',
    config = {
      week_header = {
       enable = true,
      },
      shortcut = {
        {
          desc = ' Session',
          group = 'Session',
          action = 'source Session.vim',
          key = 's',
        },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        -- {
        --   desc = ' Apps',
        --   group = 'DiagnosticHint',
        --   action = 'Telescope app',
        --   key = 'a',
        -- },
        -- {
        --   desc = ' dotfiles',
        --   group = 'Number',
        --   action = 'Telescope dotfiles',
        --   key = 'd',
        -- },
      },
      project = { enable = false },
      packages = { enable = false },
    },
})
