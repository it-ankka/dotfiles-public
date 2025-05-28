local dap = require('dap')
local dapui = require('dapui')
dapui.setup()

local function DapSetBreakpoint() dap.set_breakpoint() end
local function DapSetLogPoint() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end
local function DapReplOpen() dap.repl.open() end
local function DapRunLast() dap.run_last() end
local function DapHover() dap.ui.widgets.hover() end
local function DapPreview() dap.ui.widgets.preview() end
local function DapFrames()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end
local function DapScopes()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end

local function DapUiToggle() dapui.toggle() end

vim.api.nvim_create_user_command("DapSetBreakpoint", DapSetBreakpoint, { force = true })
vim.api.nvim_create_user_command("DapSetLogPoint", DapSetLogPoint, { force = true })
vim.api.nvim_create_user_command("DapReplOpen", DapReplOpen, { force = true })
vim.api.nvim_create_user_command("DapRunLast", DapRunLast, { force = true })
vim.api.nvim_create_user_command("DapUiToggle", DapUiToggle, { force = true })
vim.api.nvim_create_user_command("DapFrames", DapFrames, { force = true })
vim.api.nvim_create_user_command("DapScopes", DapScopes, { force = true })

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', DapSetBreakpoint)
vim.keymap.set('n', '<Leader>lp', DapSetLogPoint)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', DapHover)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', DapPreview)
vim.keymap.set({ 'n', 'v' }, '<Leader>df', DapPreview)

vim.keymap.set('n', '<Leader>df', DapFrames)
vim.keymap.set('n', '<Leader>ds', DapScopes)

-- ADAPTERS
local masonDir = vim.fn.stdpath("data") .. "/mason";

-- Dotnet
local netcoredbgPath = masonDir .. "/bin/netcoredbg"
if vim.fn.filereadable(netcoredbgPath) == 1 then
  dap.adapters.coreclr = {
    type = 'executable',
    command = netcoredbgPath,
    args = { '--interpreter=vscode' }
  }
  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }
end

-- Godot
dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}
dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}
