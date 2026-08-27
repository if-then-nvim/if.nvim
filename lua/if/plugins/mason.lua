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
      "stylua",
      "prettier",
    },
  },
}
