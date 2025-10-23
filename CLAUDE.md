# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built on top of [LazyVim](https://github.com/LazyVim/LazyVim), a Neovim starter template. The configuration uses lazy.nvim as the plugin manager.

## Architecture

### Configuration Structure

- `init.lua` - Entry point that bootstraps lazy.nvim and loads the main config
- `lua/config/` - Core configuration files:
  - `lazy.lua` - Plugin manager setup and LazyVim bootstrapping
  - `options.lua` - Neovim options (extends LazyVim defaults)
  - `keymaps.lua` - Custom keybindings (extends LazyVim defaults)
  - `autocmds.lua` - Custom autocommands (currently disables spell checking for markdown)
- `lua/plugins/` - Plugin specifications that override or extend LazyVim plugins

### Plugin Architecture

LazyVim uses a layered plugin specification system:
1. Base LazyVim plugins are imported via `{ "LazyVim/LazyVim", import = "lazyvim.plugins" }` in lua/config/lazy.lua:20
2. Custom plugins in `lua/plugins/*.lua` can override LazyVim defaults by returning a table with the same plugin name
3. Each file in `lua/plugins/` returns a plugin spec (or array of specs) that lazy.nvim merges with existing configurations

### Key Customizations

- **Formatter configuration** (lua/plugins/conform.lua:1): Uses conform.nvim with:
  - `biome` for JavaScript (requires biome.json in project root via `require_cwd`)
  - `stylua` for Lua
  - `isort` + `black` for Python
  - `rustfmt` for Rust
- **Ruby LSP** (lua/plugins/ruby.lua:1): Disables standalone rubocop LSP server in favor of ruby-lsp's built-in rubocop integration
- **Project-local configuration** (lua/plugins/nvim-config-local.lua:1): Loads `.nvim.lua`, `.nvimrc`, or `.exrc` files from project directories for per-project settings
- **Snacks.nvim** (lua/plugins/snacks.lua:1): Customizes terminal to use floating windows and sets explorer title

## Remote Control via Socket

Neovim listens on `/tmp/nvim` for remote commands. You can interact with the running instance using:

```bash
nvim --server /tmp/nvim --remote-send '<commands>'
```

Or execute Lua commands:
```bash
nvim --server /tmp/nvim --remote-expr 'lua-expression'
```

This is useful for automation, testing config changes, or integrating with external tools.

## Testing Configuration Changes

When modifying plugin configurations:
1. Changes to `lua/plugins/*.lua` files typically require restarting Neovim or running `:Lazy reload <plugin-name>`
2. The plugin manager automatically checks for updates (configured in lua/config/lazy.lua:34)
3. Use `:Lazy` to open the plugin manager UI and see plugin status
4. To test changes to core config files (options, keymaps, autocmds), restart Neovim

## Important Notes

- Plugin updates are checked automatically but notifications are disabled (lua/config/lazy.lua:36)
- Custom plugins are NOT lazy-loaded by default (lua/config/lazy.lua:27) for predictable startup behavior
- LazyVim's default options, keymaps, and autocmds are always loaded first and can be found in the [LazyVim repository](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)
