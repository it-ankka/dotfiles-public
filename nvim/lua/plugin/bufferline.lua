require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    offsets = { {
      filetype = "NvimTree",
      text = "📁 File Explorer",
      highlight = "Directory",
      text_align = "left",
    } },
  }
})

-- KEYBINDS
-- Movement between buffers
vim.keymap.set({ "n" }, "<M-l>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set({ "n" }, "<M-h>", ":BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set({ "n" }, "ﬁ", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set({ "n" }, "˛", ":BufferLineCyclePrev<CR>", { silent = true })
-- Reorganize buffers
vim.keymap.set({ "n" }, "<S-M-l>", ":BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set({ "n" }, "<S-M-h>", ":BufferLineMovePrev<CR>", { silent = true })
vim.keymap.set({ "n" }, "ﬂ", ":BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set({ "n" }, "˘", ":BufferLineMovePrev<CR>", { silent = true })
-- Pick a buffer
vim.keymap.set({ "n" }, "<M-b>", ":BufferLinePick<CR>", { silent = true })
vim.keymap.set({ "n" }, "›", ":BufferLinePick<CR>", { silent = true })
