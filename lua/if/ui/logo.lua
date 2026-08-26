local M = {}

M.STEPS = 12

M.NEOVIM_GREEN = "#57A143"
M.NEOVIM_BLUE = "#3C92D2"

---@param str string
---@param index integer
---@return integer
local function char_len(str, index)
  local b = str:byte(index)
  if not b then
    return 1
  end
  if b < 0x80 then
    return 1
  elseif b < 0xE0 then
    return 2
  elseif b < 0xF0 then
    return 3
  end
  return 4
end

---@param row string
---@param fn fun(col: integer, byte: integer, ch: string)
local function each_cell(row, fn)
  local byte = 0
  local col = 0
  while byte < #row do
    local len = char_len(row, byte + 1)
    fn(col, byte, row:sub(byte + 1, byte + len))
    col = col + 1
    byte = byte + len
  end
end

M.each_cell = each_cell

---@param row string
---@param split integer[]
---@return boolean
local function has_middle(row, split)
  local found = false
  each_cell(row, function(col, _, ch)
    if ch ~= " " and col > split[1] and col < split[2] then
      found = true
    end
  end)
  return found
end

---@param content string[]
---@param split integer[]
---@return table<integer, integer>
function M.ranks(content, split)
  local rows = {}
  for i, row in ipairs(content) do
    if has_middle(row, split) then
      rows[#rows + 1] = i
    end
  end
  local out = {}
  local n = #rows
  for k, i in ipairs(rows) do
    local t = n > 1 and (k - 1) / (n - 1) or 0
    out[i] = math.floor(t * (M.STEPS - 1) + 0.5) + 1
  end
  return out
end

---@param col integer
---@param ch string
---@param rank integer|nil
---@param split integer[]
---@return string|nil
function M.cell_hl(col, ch, rank, split)
  if ch == " " or ch == "" then
    return nil
  end
  if col <= split[1] then
    return "IfDashLogoLeft"
  end
  if col >= split[2] then
    return "IfDashLogoRight"
  end
  return "IfDashLogoMid" .. (rank or 1)
end

---@param hex string
---@return integer, integer, integer
local function to_rgb(hex)
  return tonumber(hex:sub(2, 3), 16) or 0, tonumber(hex:sub(4, 5), 16) or 0, tonumber(hex:sub(6, 7), 16) or 0
end

---@param a string
---@param b string
---@param t number
---@return string
function M.mix(a, b, t)
  local ar, ag, ab = to_rgb(a)
  local br, bg, bb = to_rgb(b)
  return string.format(
    "#%02X%02X%02X",
    math.floor(ar + (br - ar) * t + 0.5),
    math.floor(ag + (bg - ag) * t + 0.5),
    math.floor(ab + (bb - ab) * t + 0.5)
  )
end

return M
