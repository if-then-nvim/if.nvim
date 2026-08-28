local M = {}

local MIN_VERSION = { 0, 11, 0 }

---@type { module: string, plugin: string, reason: string }[]
local REQUIRED = {
  { module = "snacks", plugin = "folke/snacks.nvim", reason = "picker, explorer, terminal and the git mappings" },
  { module = "blink.cmp", plugin = "saghen/blink.cmp", reason = "completion" },
  { module = "nvim-treesitter", plugin = "nvim-treesitter/nvim-treesitter", reason = "highlighting and folds" },
  { module = "lspconfig", plugin = "neovim/nvim-lspconfig", reason = "language servers" },
  { module = "nvim-web-devicons", plugin = "nvim-tree/nvim-web-devicons", reason = "file icons" },
}

---@type { module: string, plugin: string }[]
local OPTIONAL = {
  { module = "noice", plugin = "folke/noice.nvim" },
  { module = "dropbar", plugin = "Bekaboo/dropbar.nvim" },
  { module = "gitsigns", plugin = "lewis6991/gitsigns.nvim" },
  { module = "which-key", plugin = "folke/which-key.nvim" },
  { module = "conform", plugin = "stevearc/conform.nvim" },
  { module = "ibl", plugin = "lukas-reineke/indent-blankline.nvim" },
}

local function check_version()
  local v = vim.version()
  if vim.version.ge({ v.major, v.minor, v.patch }, MIN_VERSION) then
    vim.health.ok("Neovim " .. tostring(v))
  else
    vim.health.error(("Neovim >= %s required, found %s"):format(table.concat(MIN_VERSION, "."), tostring(v)))
  end

  if vim.o.termguicolors then
    vim.health.ok "'termguicolors' is set"
  else
    vim.health.warn("'termguicolors' is off; the theme needs it", { "Set `vim.o.termguicolors = true`." })
  end
end

local function check_config()
  local from_file = pcall(require, "ifrc")
  local from_opts = type(vim.g.if_opts) == "table" and not vim.tbl_isempty(vim.g.if_opts)

  if from_file and from_opts then
    vim.health.warn("both lua/ifrc.lua and setup() opts are present; ifrc.lua wins and opts are ignored", {
      "Keep your settings in one place.",
    })
  elseif from_file then
    vim.health.ok("configuration read from " .. vim.fn.stdpath "config" .. "/lua/ifrc.lua")
  elseif from_opts then
    vim.health.ok "configuration read from setup() opts"
  else
    vim.health.info "no user configuration; defaults apply"
  end

  local config = require "if.config"

  local ok_rc, rc = pcall(require, "ifrc")
  local user = (ok_rc and type(rc) == "table" and rc) or vim.g.if_opts or {}
  local requested = type(user.theme) == "table" and user.theme.palette or nil

  if requested and not pcall(require, "if.theme.palettes." .. requested) then
    vim.health.error(("palette %q not found; using %q instead"):format(requested, config.theme.palette), {
      "Available: if-dark, if-light.",
    })
  else
    vim.health.ok(("palette %q, transparent=%s"):format(config.theme.palette, tostring(config.theme.transparent)))
  end
end

local function check_statusline()
  local config = require "if.config"
  if not config.statusline.enabled then
    vim.health.info "statusline disabled"
    return
  end

  local segments = require "if.ui.statusline.segments"
  local unknown = {}
  for _, name in ipairs(config.statusline.order) do
    if type(name) ~= "string" then
      unknown[#unknown + 1] = vim.inspect(name)
    elseif segments[name] == nil and not name:find "^%%" then
      unknown[#unknown + 1] = name
    end
  end

  if #unknown == 0 then
    vim.health.ok(("statusline.order: %d segments"):format(#config.statusline.order))
  else
    vim.health.warn("statusline.order has entries that are not segments: " .. table.concat(unknown, ", "), {
      "They render as literal text. Segments: mode, filetype, git_branch,",
      "git_diff, diagnostics, cursor, lsp, cwd, lsp_progress, spacer.",
      "Raw statusline syntax must start with %, such as %= or %<.",
    })
  end
end

local function check_cache()
  local dir = vim.fn.stdpath "cache" .. "/if.nvim"
  if vim.fn.isdirectory(dir) == 0 then
    vim.health.info("theme cache not built yet: " .. dir)
    return
  end
  if vim.fn.filewritable(dir) ~= 2 then
    vim.health.error("theme cache directory is not writable: " .. dir, {
      "The theme is recompiled on every start without it.",
    })
    return
  end
  local entries = vim.fn.readdir(dir)
  if #entries == 0 then
    vim.health.info "theme cache is empty; it builds on the next start"
  else
    vim.health.ok(("theme cache: %d compiled palette(s) in %s"):format(#entries, dir))
  end
end

local function check_plugins()
  for _, spec in ipairs(REQUIRED) do
    if pcall(require, spec.module) then
      vim.health.ok(spec.plugin)
    else
      vim.health.error(("%s is missing — needed for %s"):format(spec.plugin, spec.reason))
    end
  end

  local missing = {}
  for _, spec in ipairs(OPTIONAL) do
    if not pcall(require, spec.module) then
      missing[#missing + 1] = spec.plugin
    end
  end
  if #missing == 0 then
    vim.health.ok "all optional plugins loaded"
  else
    vim.health.info("not loaded (lazy may defer these): " .. table.concat(missing, ", "))
  end
end

local function check_treesitter()
  local ok, parsers = pcall(vim.treesitter.language.get_lang, "lua")
  if not ok or not parsers then
    vim.health.warn "tree-sitter lua parser not found; folds fall back to plain text"
    return
  end
  local installed = {}
  for _, lang in ipairs { "lua", "vim", "vimdoc", "markdown" } do
    if pcall(vim.treesitter.get_string_parser, "", lang) then
      installed[#installed + 1] = lang
    end
  end
  if #installed > 0 then
    vim.health.ok("tree-sitter parsers: " .. table.concat(installed, ", "))
  else
    vim.health.warn "no tree-sitter parser found; run :TSInstall lua vim vimdoc"
  end
end

function M.check()
  vim.health.start "if.nvim"
  check_version()
  check_config()
  check_statusline()
  check_cache()

  vim.health.start "if.nvim: plugins"
  check_plugins()

  vim.health.start "if.nvim: tree-sitter"
  check_treesitter()
end

return M
