local function setup_server(server_name, server_config)
  local opts = require("if.config").lsp
  local config = server_config or {}

  local ok, blink = pcall(require, "blink.cmp")
  config.capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

  local original_on_attach = config.on_attach
  config.on_attach = function(client, bufnr)
    if original_on_attach then
      original_on_attach(client, bufnr)
    end

    if not opts.semantic_tokens then
      client.server_capabilities.semanticTokensProvider = nil
    end

    if opts.inlay_hints and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end

  vim.lsp.config(server_name, config)
  vim.lsp.enable(server_name)
end

local function setup_diagnostic()
  local signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.HINT] = "",
    [vim.diagnostic.severity.INFO] = "",
  }

  vim.diagnostic.config {
    signs = { text = signs },
    virtual_text = {
      spacing = 2,
      source = "if_many",
      prefix = function(diagnostic)
        return diagnostic.source == "eslint" and "" or ""
      end,
      format = function(diagnostic)
        if diagnostic.source == "eslint" and diagnostic.code then
          return ("%s [%s]"):format(diagnostic.message, diagnostic.code)
        end
        return diagnostic.message or ""
      end,
    },
    severity_sort = true,
    update_in_insert = false,
  }
end

return {
  setup_server = setup_server,
  setup_diagnostic = setup_diagnostic,
}
