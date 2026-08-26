-- Loads every if.nvim module without a plugin manager.
--   nvim --clean --headless -l scripts/check_load.lua
--
-- Runs with --clean on purpose: a stale ~/.config/nvim on the developer's
-- machine must not be able to satisfy a require that would fail elsewhere.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.runtimepath:prepend(root)
vim.uv.chdir(root)

local failures = {}

local function fail(fmt, ...)
  failures[#failures + 1] = fmt:format(...)
end

-- 1. Every Lua file parses.
local sources = vim.list_extend(
  vim.fn.glob("lua/**/*.lua", false, true),
  vim.fn.glob("colors/*.lua", false, true)
)
for _, file in ipairs(sources) do
  local chunk, err = loadfile(file)
  if not chunk then
    fail("syntax: %s: %s", file, err)
  end
end
print(("parsed %d files"):format(#sources))

-- 2. Every module under lua/if/ loads.
local modules = 0
for _, file in ipairs(vim.fn.glob("lua/if/**/*.lua", false, true)) do
  local name = file:gsub("^lua/", ""):gsub("%.lua$", ""):gsub("/init$", ""):gsub("/", ".")
  local ok, err = pcall(require, name)
  if ok then
    modules = modules + 1
  else
    fail("require %q: %s", name, tostring(err):gsub("\n.*", ""))
  end
end
print(("loaded %d modules"):format(modules))

-- 3. Plugin specs are tables lazy.nvim can consume.
local specs = 0
for _, file in ipairs(vim.fn.glob("lua/if/plugins/*.lua", false, true)) do
  local name = file:gsub("^lua/", ""):gsub("%.lua$", ""):gsub("/", ".")
  local ok, spec = pcall(require, name)
  if ok and type(spec) == "table" then
    specs = specs + 1
  else
    fail("plugin spec %q is not a table", name)
  end
end
print(("checked %d plugin specs"):format(specs))

-- 4. Module names that only appear inside strings are invisible to the loader,
--    so a rename silently breaks the statusline, the bufline or a pcall'd
--    optional integration. Check the ones that name an in-tree module.
local function is_in_tree(name)
  local head = name:match "^([%w_]+)"
  return head == "if" or head == "ui" or head == "core" or head == "plugins" or head == "theme"
end

for _, file in ipairs(sources) do
  local text = table.concat(vim.fn.readfile(file), "\n")
  for name in text:gmatch("v:lua%.require%('([%w_.]+)'%)") do
    if not pcall(require, name) then
      fail("%s: v:lua.require(%q) does not resolve", file, name)
    end
  end
  for name in text:gmatch('pcall%(require, "([%w_.]+)"%)') do
    if is_in_tree(name) and not pcall(require, name) then
      fail("%s: pcall(require, %q) never succeeds", file, name)
    end
  end
end

if #failures > 0 then
  print("")
  for _, message in ipairs(failures) do
    print("FAIL " .. message)
  end
  print(("\n%d failure(s)"):format(#failures))
  vim.cmd("cquit 1")
end

print("\nall modules load")
vim.cmd("qa!")
