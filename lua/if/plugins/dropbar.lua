local function shorten_name(name)
  name = name:gsub("@[%w_%.]+%s*%b()", "")
  name = name:gsub("@[%w_%.]+", "")
  local method = name:match "([%w_%$]+)%s*%("
  if method then
    return method
  end
  return name:match "([%w_%$]+)%s*$" or name
end

local function pos_le(a, b)
  return a.line < b.line or (a.line == b.line and a.character <= b.character)
end

local function range_contains(outer, inner)
  if not (outer and inner and outer.start and inner.start) then
    return true
  end
  return pos_le(outer.start, inner.start) and pos_le(inner["end"], outer["end"])
end

local function short_names(source)
  return {
    get_symbols = function(buf, win, cursor)
      local symbols = source.get_symbols(buf, win, cursor)
      local chain = {}
      for i = #symbols, 1, -1 do
        local sym = symbols[i]
        local inner = chain[#chain]
        if not inner or range_contains(sym.range, inner.range) then
          chain[#chain + 1] = sym
        end
      end
      local result = {}
      local prev
      for i = #chain, 1, -1 do
        local sym = chain[i]
        sym.name = shorten_name(sym.name)
        if sym.name ~= prev then
          result[#result + 1] = sym
          prev = sym.name
        end
      end
      return result
    end,
  }
end

local PATH_MAX_COMPONENTS = 3

local function merge_path(source)
  return {
    get_symbols = function(buf, win, cursor)
      local symbols = source.get_symbols(buf, win, cursor)
      if #symbols <= 1 then
        return symbols
      end
      local names = {}
      for _, sym in ipairs(symbols) do
        names[#names + 1] = sym.name
      end
      local truncated = #names > PATH_MAX_COMPONENTS
      if truncated then
        local kept = {}
        for i = #names - PATH_MAX_COMPONENTS + 1, #names do
          kept[#kept + 1] = names[i]
        end
        names = kept
      end
      local last = symbols[#symbols]
      last.name = (truncated and "../" or "") .. table.concat(names, "/")
      return { last }
    end,
  }
end

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>;",
      function()
        require("dropbar.api").pick()
      end,
      desc = "dropbar pick",
    },
  },
  opts = {
    bar = {
      padding = { left = 2, right = 1 },
      sources = function(buf, _)
        local sources = require "dropbar.sources"
        local utils = require "dropbar.utils"
        if vim.bo[buf].ft == "markdown" then
          return { sources.markdown }
        end
        return {
          merge_path(sources.path),
          utils.source.fallback {
            short_names(sources.lsp),
            short_names(sources.treesitter),
          },
        }
      end,
    },
    icons = {
      ui = {
        bar = { separator = " > ", extends = "…" },
      },
    },
    sources = {
      lsp = { max_depth = 4 },
      treesitter = { max_depth = 4 },
    },
  },
}
