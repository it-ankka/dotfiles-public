local nvimTree = require("nvim-tree")

local function NvimTreeFindFileToggleSide()
  nvimTree.config.view.float.enable = false
  return vim.cmd(":NvimTreeFindFileToggle<CR>")
end

local function NvimTreeFindFileToggleFloat()
  nvimTree.config.view.float.enable = true
  return vim.cmd(":NvimTreeFindFileToggle<CR>")
end

-- Custom commands
vim.api.nvim_create_user_command("NvimTreeFindFileToggleSide", NvimTreeFindFileToggleSide, {force = true})
vim.api.nvim_create_user_command("NvimTreeFindFileToggleFloat", NvimTreeFindFileToggleFloat, {force = true})

-- Keybinds
vim.keymap.set({"n"}, "<leader>n", ":NvimTreeFindFileToggleSide<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>N", ":NvimTreeFindFileToggleFloat<CR>", {silent = true})

-- Floating window settings
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5
local WIDTH_RATIO_SMALL = 0.8

local function GetNvimTreeWidth()
  local columns = vim.opt.columns:get()
  if(nvimTree.config.view.float.enable) then
    if columns <= 150 then
      return math.floor(columns * WIDTH_RATIO_SMALL)
    end
    return math.floor(columns * WIDTH_RATIO)
  end

  local winwidth = vim.fn.winwidth(0)
  if winwidth <= 100 then
    return 30
  elseif winwidth <= 200 then
    return 40
  else
    return 50
  end
end

nvimTree.setup({
    view = {
      side = "right",
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = GetNvimTreeWidth()
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2)
                           - vim.opt.cmdheight:get()
          return {
            border = 'rounded',
            relative = 'editor',
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
          end,
      },

      width = GetNvimTreeWidth,
    },
    git = {
      ignore = false
    }
})
