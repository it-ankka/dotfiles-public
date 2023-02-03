local Plug = vim.fn['plug#']
Plug 'glepnir/dashboard-nvim'

local setupDashboard = function()
    local db = require('dashboard')
    -- db.default_executive = 'fzf'
    db.custom_header = {
'  　　　。　　　　•　 　ﾟ　　。 　　.         ',
'                                              ',
'  ﾟ 　　.　　ﾟ 　　.　　 　　　。　　 。　. 　',
'                                              ',
'  .　　 。　　　　　 ඞ 。 . 　　 • 　　　　•  ',
'                                              ',
'  　　ﾟ　　 Lassi was not An Impostor.　 。　.',
'                                              ',
'  。　ﾟ　　　 1 Impostor remains 　 　　。    ',
'                                              ',
'  　　ﾟ　　　.　　　. 。　　 　.　 .          ',
'    。           .          ﾟ             ﾟ   ',
}
end

vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = setupDashboard,
})
