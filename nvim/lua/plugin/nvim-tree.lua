vim.keymap.set({"n"}, "<leader>n", ":NvimTreeFindFileToggle<CR>", {silent = true})

require("nvim-tree").setup({
    view = {
      side = "right",
    },
    git = {
      ignore = false
    }
})

vim.api.nvim_create_autocmd("BufEnter", {
  command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
  nested = true
  }
)
