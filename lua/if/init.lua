local M = {}

function M.setup(opts)
  if opts and not vim.tbl_isempty(opts) then
    vim.g.if_opts = opts
  end

  require("if.theme.cache").setup()
  require "if.core.options"

  local config = require "if.config"
  if config.statusline.enabled then
    require("if.ui.statusline").setup()
  end
  if config.bufline.enabled then
    require("if.ui.bufline").setup()
  end

  require "if.core.autocmds"
  require("if.ui.dashboard").setup()

  vim.schedule(function()
    require "if.core.mappings"
  end)
end

return M
