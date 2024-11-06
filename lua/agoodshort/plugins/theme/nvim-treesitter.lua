return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	keys = {
		{
			"<leader>t",
			function()
				require("treesitter-context").toggle()
			end,
			desc = "Toggle Treesitter Context",
		},
	},
	dependencies = {
		{ "windwp/nvim-ts-autotag", opts = { enable_close_on_slash = true } },
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"angular",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"regex",
				"hyprlang",
				"git_config",
			},
			highlight = { enable = true },
			autotag = { enable = false },
			indent = { enable = true },
			-- select blocks with <CR>
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},
		})
	end,
}
