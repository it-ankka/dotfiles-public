vim.keymap.set({"n"}, "<leader>n", ":NvimTreeFindFileToggle<CR>", {silent = true})

require("nvim-tree").setup({
    view = {
      side = "right",
    },
    git = {
      ignore = false
    }
})
