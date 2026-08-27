local M = {}

---@param name string
function M.run(name)
  local ok_config, config = pcall(require, "if.config")
  if not ok_config then
    return
  end

  local hook = config[name]
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

return M
