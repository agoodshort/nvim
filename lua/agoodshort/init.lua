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
	},
	-- git = {
	-- 	url_format = "git@agoodshort.github.com/%s.git",
	-- },
	checker = {
		-- automatically check for plugin updates
		enabled = true,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
		check_pinned = false, -- check for pinned packages that can't be updated
	},
	ui = {
		border = "rounded",
	},
	pkg = {
		sources = {
			"lazy",
			-- "rockspec",
			"packspec",
		},
	},
}

lazy.setup({
	{ import = "agoodshort.plugins" },
	{ import = "agoodshort.plugins.git" },
	{ import = "agoodshort.plugins.lsp-formatter-linter" },
	{ import = "agoodshort.plugins.navigation" },
	{ import = "agoodshort.plugins.terminal" },
	{ import = "agoodshort.plugins.theme" },
	{ import = "agoodshort.plugins.typing" },
	{ import = "agoodshort.plugins.language-specific" },
}, lazy_defaults)
