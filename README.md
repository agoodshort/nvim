# Neovim Config

[![Plugin Manager](https://dotfyle.com/agoodshort/nvim/badges/plugin-manager?style=flat)](https://dotfyle.com/agoodshort/nvim)
[![Leaderkey](https://dotfyle.com/agoodshort/nvim/badges/leaderkey?style=flat)](https://dotfyle.com/agoodshort/nvim)
[![Last commit](https://img.shields.io/github/last-commit/agoodshort/nvim?style=flat)](https://github.com/agoodshort/nvim/commits/master)

## Install Instructions

> Install requires Neovim 0.9+.

Clone the repository and install the plugins:

```sh
git clone git@github.com:agoodshort/nvim ~/.config/agoodshort/nvim
NVIM_APPNAME=agoodshort/nvim/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=agoodshort/nvim/ nvim
```

## To Do

- [ ] Review the use of `./luarc.json` file
- [ ] Review how to use `K` when on neovim man page
- [ ] Neovim `initial_mode = "normal"` does not work for extensions git_diffs
- [ ] uncomment git config in lazy.nvim
- [ ] test [NeoAI](https://github.com/Bryley/neoai.nvim)
- [ ] [Show appropriate documentation](https://github.com/Saecki/crates.nvim/wiki/Documentation-v0.4.0#show-appropriate-documentation-in-cargotoml) in `cargo.toml`
