local default = require "if.plugins.lspconfig.servers.default"

local config = {
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      diagnostics = {
        globals = {
          "vim",
          "Snacks",
          "describe",
          "it",
          "before_each",
          "after_each",
          "assert",
          "pending",
          "spy",
          "stub",
          "mock",
        },
        disable = {
          "different-requires",
          "missing-fields",
          "duplicate-set-field",
          "close-non-object",
          "incomplete-signature-doc",
          "missing-global-doc",
          "missing-local-export-doc",
          "inject-field",
        },
      },
      completion = {
        callSnippet = "Replace",
        autoRequire = false,
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          vim.fn.stdpath "data" .. "/lazy/plenary.nvim",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
          "${3rd}/luv/library",
        },
        checkThirdParty = false,
      },
    },
  },
}

default.setup_server("lua_ls", config)
