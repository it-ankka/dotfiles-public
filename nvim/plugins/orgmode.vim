Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'

lua << EOF
    require('orgmode').setup_ts_grammar()
   -- TODO add set filelocations
    require('orgmode').setup({
      org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
      org_default_notes_file = '~/Dropbox/org/refile.org',
    })
EOF
