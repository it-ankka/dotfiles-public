vim.keymap.set({"n"}, "<leader>n", ":NvimTreeFindFileToggle<CR>", {silent = true})

require("nvim-tree").setup({
    view = {
      side = "right",
      width = function()
        local winwidth = vim.fn.winwidth(0)
        if winwidth <= 100 then
          return 30
        elseif winwidth <= 200 then
          return 40
        else
          return 50
        end
      end,
    },
    git = {
      ignore = false
    }
})
