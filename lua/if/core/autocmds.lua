local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = augroup("FilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "FilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})
        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.wo.statusline = "%!v:lua.require('if.ui.statusline').generate()"
  end,
})

autocmd("FileType", {
  pattern = "dotenv",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

local new_cmd = vim.api.nvim_create_user_command

new_cmd("Format", function(opts)
  local range
  if opts.range > 0 then
    local last_line = vim.api.nvim_buf_get_lines(0, opts.line2 - 1, opts.line2, true)[1] or ""
    range = {
      start = { opts.line1, 0 },
      ["end"] = { opts.line2, #last_line },
    }
  end

  require("conform").format {
    async = true,
    lsp_format = "fallback",
    range = range,
  }
end, { range = true, desc = "Format buffer or visual range" })

new_cmd("IfReload", function(opts)
  local name = opts.args
  if name == "" then
    vim.notify("Usage: :IfReload <module-name>", vim.log.levels.WARN)
    return
  end
  local count = 0
  for k in pairs(package.loaded) do
    if k:match("^" .. vim.pesc(name)) then
      package.loaded[k] = nil
      count = count + 1
    end
  end
  local ok, mod = pcall(require, name)
  if ok and type(mod) == "table" and mod.setup then
    mod.setup()
  end
  vim.notify(("[%s] reloaded (%d modules)"):format(name, count), vim.log.levels.INFO)
end, {
  nargs = 1,
  complete = function(arg_lead)
    local names = {}
    for k in pairs(package.loaded) do
      local root = k:match "^([^%.]+)"
      if root and root:match("^" .. vim.pesc(arg_lead)) then
        names[root] = true
      end
    end
    return vim.tbl_keys(names)
  end,
  desc = "Reload a Lua module by name",
})
