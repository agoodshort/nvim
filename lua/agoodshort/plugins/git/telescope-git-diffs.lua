return {
	{
		"paopaol/telescope-git-diffs.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			local actions = require("diffview.actions")
			require("diffview").setup({
				view = {
					default = {
						winbar_info = true,
					},
					file_history = {
						winbar_info = true,
					},
				},
				keymaps = {
					view = {
						{
							"n",
							"<Leader>e",
							actions.toggle_files,
							{ desc = "Toggle the file panel." },
						},
					},
					file_panel = {
						{
							"n",
							"<Leader>e",
							actions.toggle_files,
							{ desc = "Toggle the file panel" },
						},
					},
					file_history_panel = {
						{
							"n",
							"<Leader>e",
							actions.toggle_files,
							{ desc = "Toggle the file panel" },
						},
					},
				},
			})
		end,
	},
}
