return {
	{
		"nixenjoyer/markmap.nvim",
		branch = "feat/markmap_cmd-in-config",
		cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
		opts = {
			html_output = "", -- (default) Setting a empty string "" here means: [Current buffer path].html
			hide_toolbar = false, -- (default)
			grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
			markmap_cmd = "npx --yes markmap-cli",
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = "markdown",
		lazy = true,
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
	{
		"AckslD/nvim-FeMaco.lua", -- Edit code blocks in Markdown in a separate window
		ft = "markdown",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
