# My Personal Neovim Config

A minimal, LSP-powered Neovim configuration using lazy.nvim for plugin management.

## Features

- **Plugin Manager**: lazy.nvim (auto-bootstraps on first launch)
- **LSP Support**: Multiple language servers via Mason
- **Fuzzy Finding**: Telescope for files, grep, buffers
- **File Navigation**: Harpoon 2 for quick file jumping
- **Git Integration**: vim-gitgutter for inline git status
- **File Explorer**: nvim-tree
- **Completion**: nvim-cmp with LSP integration
- **Theme**: Gruvbox

## Prerequisites

- Neovim 0.11+ (uses native LSP API)
- Git
- ripgrep (for Telescope live_grep)
- A Nerd Font (for icons in nvim-tree)

## Installation

```bash
git clone https://github.com/SvArx/nvim ~/.config/nvim
nvim
```

On first launch, lazy.nvim will automatically install and all plugins will be downloaded.

## Supported Languages

LSP servers are automatically installed for:
- Lua (lua_ls)
- Python (pyright)
- Zig (zls)
- C/C++ (clangd)
- Rust (rust_analyzer)
- Go (gopls)
- Bash (bashls)
- Elixir (elixirls)
- TypeScript/JavaScript (ts_ls)
- Svelte (svelte)

## Key Bindings

Leader key: `,`

### Telescope
- `,ff` - Find files
- `,fg` - Live grep
- `,fb` - Find buffers
- `,fh` - Help tags

### Harpoon
- `,a` - Add file to Harpoon
- `,m` - Toggle Harpoon menu
- `,1` / `,2` / `,3` / `,4` - Jump to file 1-4
- `Ctrl+Shift+P` - Previous Harpoon file
- `Ctrl+Shift+N` - Next Harpoon file

### LSP
- `gd` - Go to definition
- `K` - Hover documentation
- `,rn` / `gR` - Rename symbol
- `,ca` - Code action
- `gr` - Find references
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `,d` - Show diagnostic float

### File Explorer
- `,e` - Toggle nvim-tree

## Maintenance

- **Update plugins**: `:Lazy sync`
- **Update LSP servers**: `:Mason`
- **Check health**: `:checkhealth`

## License

GPL-3.0 - See LICENSE file for details
