local o = vim.o
local opt = vim.opt
local g = vim.g

o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"
o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "line"

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = false
o.numberwidth = 2
o.ruler = false

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true
o.updatetime = 250

o.conceallevel = 0

opt.shortmess:append "sI"
opt.whichwrap:append "<>[]hl"
opt.fillchars = { eob = " " }
opt.fillchars:append { diff = "╱", fold = " ", foldopen = "", foldclose = "" }

o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldenable = true
o.foldlevel = 99

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

local sep = vim.fn.has "win32" ~= 0 and "\\" or "/"
local delim = vim.fn.has "win32" ~= 0 and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

vim.filetype.add {
  extension = {
    mdx = "mdx",
    log = "log",
    conf = "conf",
    env = "dotenv",
    xhtml = "html",
    http = "http",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
    ["tsconfig.json"] = "jsonc",
    ["tsconfig.base.json"] = "jsonc",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
}
