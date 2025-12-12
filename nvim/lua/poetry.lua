-- Use poetry venv when in poetry project
local checkForPoetryLockfile = function()
  local match = vim.fn.glob(vim.fn.getcwd() .. "/poetry.lock")
  if match ~= "" then
    local poetry_venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
    local path_extended = string.format("%s/bin:%s", poetry_venv, vim.env.PATH)
    vim.env.VIRTUAL_ENV = poetry_venv
    vim.env.PATH = path_extended
  end
end

checkForPoetryLockfile()

vim.api.nvim_create_autocmd({ "DirChanged" }, {
  callback = function()
    checkForPoetryLockfile()
  end,
})
