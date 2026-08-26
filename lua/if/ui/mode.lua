local M = {}

local NORMAL = "IfNormalMode"
local VISUAL = "IfVisualMode"
local SELECT = "IfSelectMode"
local INSERT = "IfInsertMode"
local REPLACE = "IfReplaceMode"
local COMMAND = "IfCommandMode"
local CONFIRM = "IfConfirmMode"
local TERMINAL = "IfTerminalMode"
local TERMINAL_OFF = "IfNTerminalMode"

M.modes = {
  ["n"] = { "NORMAL", NORMAL, "" },
  ["niI"] = { "NORMAL / INSERT", NORMAL, "" },
  ["niR"] = { "NORMAL / REPLACE", NORMAL, "" },
  ["niV"] = { "NORMAL / V-REPLACE", NORMAL, "" },
  ["nt"] = { "TERMINAL_OFF", TERMINAL_OFF, "" },
  ["ntT"] = { "TERMINAL_OFF", TERMINAL_OFF, "" },

  ["no"] = { "PENDING", NORMAL, "" },
  ["nov"] = { "PENDING CHAR", NORMAL, "" },
  ["noV"] = { "PENDING LINE", NORMAL, "" },
  ["no\22"] = { "PENDING BLOCK", NORMAL, "" },

  ["v"] = { "VISUAL", VISUAL, "" },
  ["vs"] = { "VISUAL / SELECT", VISUAL, "" },
  ["V"] = { "V-LINE", VISUAL, "" },
  ["Vs"] = { "V-LINE / SELECT", VISUAL, "" },
  ["\22"] = { "V-BLOCK", VISUAL, "" },
  ["\22s"] = { "V-BLOCK / SELECT", VISUAL, "" },

  ["s"] = { "SELECT", SELECT, "" },
  ["S"] = { "S-LINE", SELECT, "" },
  ["\19"] = { "S-BLOCK", SELECT, "" },

  ["i"] = { "INSERT", INSERT, "" },
  ["ic"] = { "INSERT / COMPLETE", INSERT, "" },
  ["ix"] = { "INSERT / COMPLETE", INSERT, "" },

  ["R"] = { "REPLACE", REPLACE, "" },
  ["Rc"] = { "REPLACE / COMPLETE", REPLACE, "" },
  ["Rx"] = { "REPLACE / COMPLETE", REPLACE, "" },
  ["Rv"] = { "V-REPLACE", REPLACE, "" },
  ["Rvc"] = { "V-REPLACE / COMPLETE", REPLACE, "" },
  ["Rvx"] = { "V-REPLACE / COMPLETE", REPLACE, "" },

  ["c"] = { "COMMAND", COMMAND, "" },
  ["cv"] = { "EX", COMMAND, "" },
  ["ce"] = { "EX", COMMAND, "" },

  ["r"] = { "PROMPT", CONFIRM, "" },
  ["rm"] = { "MORE", CONFIRM, "" },
  ["r?"] = { "CONFIRM", CONFIRM, "" },
  ["x"] = { "CONFIRM", CONFIRM, "" },

  ["t"] = { "TERMINAL", TERMINAL, "" },
  ["!"] = { "SHELL", TERMINAL, "" },
}

M.special = {
  ["snacks_picker_list"] = { "EXPLORER", "IfExplorerMode", "" },
  ["lazygit"] = { "LAZY_GIT", "IfLazyGitMode", "" },
  ["lazy"] = { "LAZY_NVIM", "IfLazyNvimMode", "󰒲" },
  ["qf"] = { "QUICK_FIX", "IfLazyNvimMode", "" },
}

---@param mode_key string
---@return table|nil
function M.get(mode_key)
  return M.modes[mode_key]
end

---@param filetype string
---@return table|nil
function M.get_special(filetype)
  return M.special[filetype]
end

---@param mode_key string
---@return string
function M.hl(mode_key)
  local m = M.modes[mode_key]
  return m and m[2] or NORMAL
end

---@param mode_key string
---@return string
function M.icon(mode_key)
  local m = M.modes[mode_key]
  return m and m[3] or ""
end

return M
