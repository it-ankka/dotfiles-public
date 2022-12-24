;; COLOR SETTINGS

(fn _G.SetColors [color] 
  (let [color (or color "mycolor")]
    (vim.cmd.colorscheme color)
    (vim.api.nvim_set_hl 0 "Normal" {:bg "none"})
    (vim.api.nvim_set_hl 0 "NormalFloat" {:bg "none"})
    (vim.api.nvim_set_hl 0 "FloatBorder" {:fg "white"})))

(_G.SetColors)
