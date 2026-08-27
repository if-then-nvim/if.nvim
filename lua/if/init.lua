local M = {}

---@param name string
local function run_hook(name)
  local hook = require("if.config")[name]
  if type(hook) ~= "function" then
    return
  end
  local ok, err = pcall(hook)
  if not ok then
    vim.schedule(function()
      vim.notify(("if.nvim: %s hook failed: %s"):format(name, err), vim.log.levels.ERROR)
    end)
  end
end

function M.setup(opts)
  if opts and not vim.tbl_isempty(opts) then
    vim.g.if_opts = opts
  end

  require("if.theme.cache").setup()
  require "if.core.options"
  run_hook "options"

  local config = require "if.config"
  if config.statusline.enabled then
    require("if.ui.statusline").setup()
  end
  if config.bufline.enabled then
    require("if.ui.bufline").setup()
  end

  require "if.core.autocmds"
  run_hook "autocmds"

  require("if.ui.dashboard").setup()

  vim.schedule(function()
    require "if.core.mappings"
    run_hook "mappings"
  end)
end

return M
