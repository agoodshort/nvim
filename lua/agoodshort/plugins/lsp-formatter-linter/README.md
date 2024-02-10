# Configure languages

## General overview

LSP servers, Formatters and Linters are installed through `mason-tool-installer.nvim` unless specified otherwise below.

All keymaps are configured in [whichkey.lua](lua/agoodshort/plugins/lsp-formatter-linter/whichkey.lua).

### Special cases

#### Rust

Rust tools are installed through `rustup` and then used via [rustaceanvim](https://github.com/mrcjkb/rustaceanvim).

`rustup` is installed on the machine via chezmoi. More information in [agoodshort dotfiles tools](https://github.com/agoodshort/dotfiles/blob/main/docs/TOOLS.md#rust)

#### Shellcheck

[Shellcheck](https://github.com/koalaman/shellcheck) is only installed through [mason-tool-installer](https://github.com/williamboman/mason-tool-installer), no configuration is required in [nvim-linter.lua](lua/agoodshort/plugins/lsp-formatter-linter/nvim-linter.lua).
Shellcheck is used automatically by [bash-language-server](https://github.com/bash-lsp/bash-language-server#dependencies).

## Installation

1. Find the tool you want to install in `:Mason` and read its description
2. Add the tool's name (as displayed in `:Mason`) to the [mason-tool-installer.lua](lua/agoodshort/plugins/lsp-formatter-linter/mason-tool-installer.lua) file
3. Restart Neovim and the tool installs automatically
4. Configure it following the instructions below

### LSP servers

If needed, LSP servers (i.e. handler) are configured in [mason.lua](lua/agoodshort/plugins/lsp-formatter-linter/mason.lua).
Generally LSP servers works out of the box through [lspsaga.lua](lua/agoodshort/plugins/lsp-formatter-linter/lspsaga.lua).

#### Usage

- Use `K` to display the LSP Hover Doc
- Use `]g` and `[g` to jump to the next/previous LSP diagnostic
- The rest of the LSP keymaps have a keymap starting by `<leader>l` or `g`

### Formatters

After installing a formatting tool through `:Mason`, associate a file type with it in [conform.lua](lua/agoodshort/plugins/lsp-formatter-linter/conform.lua).

#### Usage

- Formatting happens through the `<leader>=` keymap
- To troubleshoot the formatter, use the `:ConformInfo` command

### Linters

After installing a formatting tool through `:Mason`, associate a file type with it in [nvim-lint.lua](lua/agoodshort/plugins/lsp-formatter-linter/nvim-lint.lua).

#### Usage

- Linting happens when buffer is written `:w` (i.e. BufWritePost)
