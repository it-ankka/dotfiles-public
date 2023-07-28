local nvimTree = require("nvim-tree")

local function NvimTreeFindFileToggleSide()
  print("Opening Side")
  nvimTree.config.view.float.enable = false
  return vim.cmd(":NvimTreeFindFileToggle<CR>")
end

local function NvimTreeFindFileToggleFloat()
  print("Opening Float")
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

nvimTree.setup({
    view = {
      side = "right",
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
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

      width = function()
        local winwidth = vim.fn.winwidth(0)

        if(nvimTree.config.view.float.enable) then
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end

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
