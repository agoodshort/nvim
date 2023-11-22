require("agoodshort.set")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- import lazy safely
local status, lazy = pcall(require, "lazy")
if not status then
	return
end

local lazy_defaults = {
	defaults = {
		lazy = false,
		git = {
			url_format = "git@agoodshort.github.com/%s.git",
		},
	},
}

lazy.setup({
	{ import = "agoodshort.plugins" },
	{ import = "agoodshort.plugins.lsp" },
	{ import = "agoodshort.plugins.navigation" },
	{ import = "agoodshort.plugins.terminal" },
	{ import = "agoodshort.plugins.theme" },
	{ import = "agoodshort.plugins.typing" },
	{ import = "agoodshort.plugins.git" },
}, lazy_defaults)
