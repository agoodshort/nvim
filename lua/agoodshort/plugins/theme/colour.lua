return {
	"uga-rosa/ccc.nvim", -- displays colour on codes
	event = "BufReadPost",
	config = function()
		require("ccc").setup({
			highlighter = {
				auto_enable = true,
			},
		})

		require("which-key").add({
			{ "<leader><leader>c", group = "Colour" },
			{ "<leader><leader>cp", "<cmd>CccPick<cr>", desc = "Pick Colour" },
			{ "<leader><leader>cc", "<cmd>CccConvert<cr>", desc = "Convert Colour" },
			{ "<leader><leader>ct", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle Colour Highlighter" },
		})
	end,
}
