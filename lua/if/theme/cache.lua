local M = {}

local root = debug.getinfo(1, "S").source:sub(2):gsub("/lua/if/theme/cache%.lua$", "")
local cache_dir = vim.fn.stdpath "cache" .. "/if.nvim"

local sources = {
  root .. "/lua/if/theme/init.lua",
  root .. "/lua/if/defaults.lua",
  root .. "/lua/if/ui/cmp.lua",
  vim.fn.stdpath "config" .. "/lua/ifrc.lua",
}

local function get_palette()
  return require("if.config").theme.palette
end

---@return string
local function cache_key()
  local config = require "if.config"
  local header = config.dashboard and config.dashboard.components and config.dashboard.components.header
  return table.concat({
    config.theme.palette,
    tostring(config.theme.transparent),
    tostring(config.style),
    tostring(header and header.color),
  }, "-")
end

local function cache_path()
  return cache_dir .. "/" .. cache_key()
end

local function palette_source()
  return root .. "/lua/if/theme/palettes/" .. get_palette() .. ".lua"
end

local function newer(a, b)
  if a.sec ~= b.sec then
    return a.sec > b.sec
  end
  return (a.nsec or 0) > (b.nsec or 0)
end

local function is_stale()
  local path = cache_path()
  local cache_stat = vim.uv.fs_stat(path)
  if not cache_stat then
    return true
  end
  local cache_mtime = cache_stat.mtime

  local all_sources = { palette_source() }
  for _, s in ipairs(sources) do
    all_sources[#all_sources + 1] = s
  end

  for _, src in ipairs(all_sources) do
    local s = vim.uv.fs_stat(src)
    if s and newer(s.mtime, cache_mtime) then
      return true
    end
  end
  return false
end

local term_map = {
  [0] = "black",
  [1] = "red",
  [2] = "green",
  [3] = "yellow",
  [4] = "blue",
  [5] = "magenta",
  [6] = "cyan",
  [7] = "white",
  [8] = "charcoal",
  [9] = "peach",
  [10] = "lime",
  [11] = "lemon",
  [12] = "sky",
  [13] = "lavender",
  [14] = "aqua",
  [15] = "ivory",
}

function M.compile()
  vim.fn.mkdir(cache_dir, "p")

  for k in pairs(package.loaded) do
    if k == "ifrc" or k == "if.config" or k:find "^if%.theme" or k == "if.ui.cmp" then
      package.loaded[k] = nil
    end
  end

  local theme = require "if.theme"
  local groups = {
    theme.base,
    theme.syntax,
    theme.treesitter,
    theme.statusline,
    theme.dropbar,
    theme.diagnostics,
    theme.lsp,
    theme.lazy,
    theme.mason,
    theme.misc,
    theme.dashboard,
    theme.explorer,
  }

  local ok_cmp, cmp_ui = pcall(require, "if.ui.cmp")
  if ok_cmp then
    if cmp_ui.override then
      groups[#groups + 1] = cmp_ui.override
    end
    if cmp_ui.add then
      groups[#groups + 1] = cmp_ui.add
    end
  end
  groups[#groups + 1] = theme.plugins

  local merged = {}
  for _, g in ipairs(groups) do
    for name, opts in pairs(g) do
      if opts.link == "" then
        local t = {}
        for k, v in pairs(opts) do
          t[k] = v
        end
        t.link = nil
        opts = t
      end
      merged[name] = opts
    end
  end

  local lines = {}
  local inspect_opts = { newline = "", indent = "" }
  for name, opts in pairs(merged) do
    lines[#lines + 1] = ("vim.api.nvim_set_hl(0,%q,%s)"):format(name, vim.inspect(opts, inspect_opts))
  end

  local palette = require("if.theme.palettes." .. get_palette())
  for i = 0, 15 do
    local key = term_map[i]
    if palette[key] then
      lines[#lines + 1] = ("vim.g.terminal_color_%d=%q"):format(i, palette[key])
    end
  end

  local body = table.concat(lines, "\n")
  local fn, err = load(body)
  if not fn then
    error("if.nvim: theme compile failed: " .. (err or "unknown"))
  end

  fn()

  local f = io.open(cache_path(), "wb")
  if not f then
    return false
  end
  f:write(string.dump(fn))
  f:close()
  return true
end

function M.load()
  local fn = loadfile(cache_path())
  if not fn then
    return false
  end
  if not pcall(fn) then
    os.remove(cache_path())
    return false
  end
  vim.g.colors_name = "if"
  return true
end

function M.clear()
  local handle = vim.uv.fs_scandir(cache_dir)
  if not handle then
    return
  end
  while true do
    local name = vim.uv.fs_scandir_next(handle)
    if not name then
      break
    end
    os.remove(cache_dir .. "/" .. name)
  end
end

function M.setup()
  if not is_stale() and M.load() then
    return
  end

  local ok, err = pcall(M.compile)
  if not ok then
    vim.notify("if.nvim: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  if not M.load() then
    vim.g.colors_name = "if"
  end
end

vim.api.nvim_create_user_command("IfThemeRecompile", function()
  M.compile()
  M.load()
  vim.notify("theme cache rebuilt", vim.log.levels.INFO)
end, { desc = "Rebuild theme highlight cache" })

return M
