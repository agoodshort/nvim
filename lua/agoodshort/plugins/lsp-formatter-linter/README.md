# Configure languages

## General overview

LSP servers, Formatters and Linters are installed through `mason-tool-installer.nvim` unless specified otherwise below.

All keymaps are configured in [whichkey.lua](lua/agoodshort/plugins/lsp-formatter-linter/whichkey.lua).

### Special cases

#### Rust

For Rust tools, it installed through `rustup` (TODO: add more details).

## Installation

1. Find the tool you want to install in `:Mason` and read its description
2. Add the tool's name (as displayed in `:Mason`) to the [mason-tool-installer.lua](lua/agoodshort/plugins/lsp-formatter-linter/mason-tool-installer.lua) file
3. Restart Neovim and the tool will be installed automatically

### LSP servers

If needed, LSP servers (i.e. handler) are configured in [mason.lua](lua/agoodshort/plugins/lsp-formatter-linter/mason.lua), but generally LSP servers works out of the box through [lspsaga.lua](lua/agoodshort/plugins/lsp-formatter-linter/lspsaga.lua).

Use `K` to display the LSP Hover Doc.
Use `]g` and `[g` to jump to the next/previous LSP diagnostic.
The rest of the LSP keymaps have a keymap starting by `<leader>l` or `g`

### Formatters

After installing the formatting tool, associate a file type with it in [conform.lua](lua/agoodshort/plugins/lsp-formatter-linter/conform.lua).

Formatting happens through the `<leader>=` keymap.
To troubleshoot the formatter, use the `:ConformInfo` command.
