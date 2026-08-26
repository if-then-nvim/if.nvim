return {
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  config = function()
    vim.schedule(function()
      local default = require "if.plugins.lspconfig.servers.default"

      local configured_servers = {
        "lua_ls",
        "ts_ls",
        "eslint",
        "cssls",
        "tailwindcss",
        "vue_ls",
        "yamlls",
      }

      local default_servers = {
        "html",
        "jsonls",
        "taplo",
        "biome",
        "astro",
      }

      default.setup_diagnostic()

      for _, server in ipairs(configured_servers) do
        local ok, err = pcall(require, "if.plugins.lspconfig.servers." .. server)
        if not ok then
          vim.notify(("if.nvim: failed to load LSP config %q\n%s"):format(server, err), vim.log.levels.WARN)
        end
      end

      for _, server in ipairs(default_servers) do
        default.setup_server(server)
      end

      for _, server in ipairs(require("if.config").lsp.servers) do
        default.setup_server(server)
      end
    end)
  end,
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {},
    },
  },
}
