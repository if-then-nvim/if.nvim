local defaults = require "if.defaults"

local function user_config()
  local ok, rc = pcall(require, "ifrc")
  if ok and type(rc) == "table" then
    return rc
  end
  return vim.g.if_opts or {}
end

local user = user_config()
local config = vim.tbl_deep_extend("force", defaults, user)

if user.statusline and user.statusline.order then
  config.statusline.order = user.statusline.order
end
if user.dashboard and user.dashboard.grid then
  config.dashboard.grid = user.dashboard.grid
end

if not pcall(require, "if.theme.palettes." .. config.theme.palette) then
  local requested = config.theme.palette
  config.theme.palette = defaults.theme.palette
  vim.schedule(function()
    vim.notify(
      ("if.nvim: unknown palette %q, falling back to %q"):format(requested, config.theme.palette),
      vim.log.levels.WARN
    )
  end)
end

return config
