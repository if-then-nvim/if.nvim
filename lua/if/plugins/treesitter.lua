vim.treesitter.language.register("bash", "dotenv")
vim.treesitter.language.register("bash", "zsh")
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("tsx", "handlebars")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.parsers").less = {
        install_info = {
          url = "https://github.com/jimliang/tree-sitter-less",
          branch = "master",
          files = { "src/parser.c", "src/scanner.c" },
        },
      }
      vim.filetype.add { extension = { less = "less" } }
    end,
  },
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "html",
        "javascriptreact",
        "javascript",
        "typescript",
        "typescriptreact",
        "tsx",
        "jsx",
        "vue",
      },
    },
  },
}
