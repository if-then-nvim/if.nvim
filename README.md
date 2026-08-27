<p align="center">
  <img src="https://raw.githubusercontent.com/if-then-nvim/.github/main/assets/logo.svg" width="200" alt="if">
</p>

<p align="center">
  A Neovim distribution with a hand-built UI layer — statusline, bufline,
  dashboard — and a theme engine that compiles its highlights to Lua bytecode.
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/if-then-nvim/.github/main/assets/hero.webp" width="100%" alt="if.nvim">
</p>

## Requirements

- Neovim >= 0.11
- A [Nerd Font](https://www.nerdfonts.com/)
- `git`, `make`, a C compiler (for treesitter and LuaSnip)

## Install

Do not clone this repository into `~/.config/nvim`. Use the starter template:

```bash
git clone https://github.com/if-then-nvim/if-starter ~/.config/nvim
nvim
```

The starter bootstraps `lazy.nvim` and pulls `if.nvim` in as a plugin, so
`:Lazy update` upgrades the distribution without touching your own config.

## Configuring

Everything lives in `lua/ifrc.lua` in your config directory. Any key you omit
falls back to `lua/if/defaults.lua`.

```lua
local M = {}

M.theme = {
  palette = "if-dark", -- or "if-light"
  transparent = true,
}

M.statusline = {
  order = { "mode", "filetype", "lsp", "git_branch", "%=", "diagnostics", "cursor" },
}

M.lsp = { servers = { "gopls", "pyright" } }

return M
```

Four servers are configured out of the box — `lua_ls`, `ts_ls`, `eslint` and
`cssls`. Anything you add to `lsp.servers` is enabled with the same
capabilities; install it with `:Mason`.

Every option, and how to override a plugin spec the distribution ships, is in
`:help if.nvim`. `:checkhealth if` reports where your settings were read from
and what is missing.

## What the UI depends on

The UI is written here, but it reads state from a few plugins rather than
reimplementing them.

| Required | For |
|---|---|
| [snacks.nvim](https://github.com/folke/snacks.nvim) | picker, explorer, terminal, git mappings |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | completion menu |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | highlighting and folds |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | language servers |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | file icons |

| Optional | For |
|---|---|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `git_branch` and `git_diff` segments |
| [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim) | winbar |
| [noice.nvim](https://github.com/folke/noice.nvim) | messages and cmdline |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | mapping hints |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | formatting |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | indent guides |

The UI degrades quietly when an optional one is absent.

## Development

```sh
make lint     # stylua --check + selene
make format   # stylua
nvim --clean --headless -l scripts/check_load.lua   # every module loads
```

`check_load.lua` runs with `--clean` on purpose: a stale `~/.config/nvim` must
not be able to satisfy a require that would fail on someone else's machine.

## Credits

if.nvim owes its shape to work that came before it.

- **[NvChad](https://github.com/NvChad)** — the architecture follows NvChad's:
  a statusline and a bufline assembled from named segments, a grid-based
  dashboard, and a theme engine that compiles highlights to bytecode and caches
  them. The code here is written from scratch, but the design is not original
  to it.
- **[base46](https://github.com/NvChad/base46)** — where the bytecode-cache
  approach was learnt from.
- **[Atom One Dark](https://github.com/atom/one-dark-syntax)** — the syntax
  colours. Surfaces, borders and the extra accents are this distribution's own.
- **[Catppuccin](https://github.com/catppuccin/nvim)** — the palette naming
  (`peach`, `sapphire`, `lavender`, `mint`, …). The values behind those names
  are not Catppuccin's.
- **[Neovim](https://neovim.io)** — the dashboard logo borrows Neovim's own
  green and blue.

## License

MIT. See [LICENSE](LICENSE).
