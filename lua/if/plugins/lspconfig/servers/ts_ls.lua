local default = require "if.plugins.lspconfig.servers.default"
local TS_IGNORE = {
  [1005] = true, -- ',' expected
  [1109] = true, -- expression expected
  [1136] = true, -- property assignment expected
  [1002] = true, -- unterminated string literal
  [1003] = true, -- identifier expected
  [1128] = true, -- declaration or statement expected
  [1127] = true, -- invalid character
}

local config = {
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, params, ctx, handler_config)
      if params.diagnostics then
        params.diagnostics = vim.tbl_filter(function(diagnostic)
          return not TS_IGNORE[diagnostic.code]
        end, params.diagnostics)
      end
      vim.lsp.handlers["textDocument/publishDiagnostics"](err, params, ctx, handler_config)
    end,
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
}

default.setup_server("ts_ls", config)
