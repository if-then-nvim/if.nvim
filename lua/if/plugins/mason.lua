return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = {
    ui = {
      backdrop = 100,
      border = "single",
    },
    ensure_installed = {
      "lua-language-server",
      "typescript-language-server",
      "vscode-eslint-language-server",
      "css-lsp",
      "stylua",
      "prettier",
    },
  },
}
