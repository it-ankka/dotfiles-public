-- COLOR SETTINGS
function SetColors(color)
  local color0 = (color or "solokai")
  vim.cmd.colorscheme(color0)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  return vim.api.nvim_set_hl(0, "FloatBorder", { fg = "white" })
end

return _G.SetColors()
