# if.nvim

A Neovim distribution with a hand-built UI layer — statusline, bufline, dashboard
— and a theme engine that compiles its highlights to Lua bytecode.

```
if ... then ... end
```

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
  palette = "if-dark",  -- or "if-light"
  transparent = true,
}

M.statusline = {
  order = { "mode", "filetype", "lsp", "git_branch", "%=", "diagnostics", "cursor" },
}

M.bufline = { align = "center" }

M.lsp = { servers = { "gopls", "pyright" } }

return M
```

List-valued options (`statusline.order`, `dashboard.grid`) replace the default
outright rather than merging into it.

Run `:checkhealth if` to see where your settings were read from and what is
missing. Full reference: `:help if.nvim`.

## What the UI depends on

The UI is written here, but it reads state from a few plugins rather than
reimplementing them.

| Plugin | Used by |
|---|---|
| [snacks.nvim](https://github.com/folke/snacks.nvim) | picker, explorer, terminal, git mappings |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | completion menu |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | highlighting and folds |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | language servers |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | file icons in the statusline, bufline and dashboard |

These are optional — the UI degrades quietly when they are absent.

| Plugin | Used by |
|---|---|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `git_branch` and `git_diff` statusline segments |
| [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim) | winbar |
| [noice.nvim](https://github.com/folke/noice.nvim) | messages and cmdline |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | mapping hints |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | formatting |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | indent guides |

## Language servers

Configured out of the box: `lua_ls`, `ts_ls`, `eslint`, `cssls`, `tailwindcss`,
`vue_ls`, `yamlls`, plus `html`, `jsonls`, `taplo`, `biome` and `astro` on
default capabilities.

Servers listed in `lsp.servers` are enabled with the same capabilities and
`on_attach` as the built-ins. Install the server itself with `:Mason`.

```lua
M.lsp = {
  servers = { "gopls", "rust_analyzer" },
  semantic_tokens = false,  -- they repaint over the compiled theme
  inlay_hints = false,
}
```

## Theme

Highlights are compiled to Lua bytecode and cached under
`stdpath("cache")/if.nvim/`, so startup does not pay for building the highlight
table. The cache rebuilds when a palette, the theme module or your `ifrc.lua`
changes.

| | |
|---|---|
| Palettes | `if-dark`, `if-light` |
| Colorscheme name | `if` |
| Rebuild manually | `:IfThemeRecompile` |

Highlight groups are prefixed `If*` (`IfNormalMode`, `IfDashAscii`, …).

The dashboard banner can be drawn in one flat colour, in the palette's own
green and blue, or in Neovim's — see `:help if-config-dashboard-color`.

## Layout

```
lua/if/
├── init.lua      entry point, called by lazy as require("if").setup(opts)
├── defaults.lua  default configuration
├── config.lua    defaults merged with the user's ifrc.lua
├── core/         options, mappings, autocmds
├── ui/           statusline, bufline, dashboard, explorer, cmp, ascii assets
├── theme/        palettes and the compiled highlight cache
└── plugins/      plugin specifications, imported by lazy
```

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
  approach was learnt from. base46 in turn credits
  [nullchilly](https://github.com/nullchilly) and
  [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) for it.
- **[Atom One Dark](https://github.com/atom/one-dark-syntax)** — the syntax
  colours. Surfaces, borders and the extra accents are this distribution's own.
- **[Catppuccin](https://github.com/catppuccin/nvim)** — the palette naming
  (`peach`, `sapphire`, `lavender`, `mint`, …). The values behind those names
  are not Catppuccin's.
- **[Neovim](https://neovim.io)** — the dashboard logo borrows Neovim's own
  green and blue.

## License

This is free and unencumbered software released into the public domain. See
[LICENSE](LICENSE).
