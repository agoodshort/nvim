# Neovim Config

[![Plugin Manager](https://dotfyle.com/agoodshort/nvim/badges/plugin-manager?style=flat)](https://dotfyle.com/agoodshort/nvim)
[![Leaderkey](https://dotfyle.com/agoodshort/nvim/badges/leaderkey?style=flat)](https://dotfyle.com/agoodshort/nvim)
[![Last commit](https://img.shields.io/github/last-commit/agoodshort/nvim?style=flat)](https://github.com/agoodshort/nvim/commits/master)

![swappy-20240209_152912](https://github.com/agoodshort/nvim/assets/33832653/4da91f67-0005-4a31-b166-e2cdd43c56a7)

## Installation

> Install requires Neovim 0.9+.

Clone the repository and install the plugins:

```sh
git clone git@github.com:agoodshort/nvim ~/.config/agoodshort/nvim
NVIM_APPNAME=agoodshort/nvim/ nvim --headless +"Lazy! restore" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=agoodshort/nvim/ nvim
```

## Tips

### LSPs, formatters and linters

DOcumentation on the configuration of LSPs, formatters and linters is available in this [README.md](lua/agoodshort/plugins/lsp-formatter-linter/README.md)

### Search and replace

The below applies when replacing using `:%s`.

- You can use `<C-r><C-w>` to get the word under the cursor into to command line.
- When a word was already searched (e.g. `\word`), use `:%s//` to replace the word searched.

## To Do

- [ ] Review the use of `./luarc.json` file
- [ ] Review how to use `K` when on neovim man page
- [ ] Neovim `initial_mode = "normal"` does not work for extensions git_diffs
- [ ] uncomment git config in lazy.nvim
- [ ] test [NeoAI](https://github.com/Bryley/neoai.nvim)
- [ ] [Show appropriate documentation](https://github.com/Saecki/crates.nvim/wiki/Documentation-v0.4.0#show-appropriate-documentation-in-cargotoml) in `cargo.toml`
- [ ] Telescope live grep to wrap lines. Check if plugin can do this, otherwise see [telescope.nvim documentation](https://github.com/nvim-telescope/telescope.nvim#previewers)
- [ ] install nvim-treesitter-context
