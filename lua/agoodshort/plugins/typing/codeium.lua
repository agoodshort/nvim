return {
	"Exafunction/codeium.nvim",
	event = "BufReadPre",
	keys = { {
		"<leader>C",
		"<cmd>Codeium Chat<cr>",
		desc = "Codeium Chat",
	} },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_chat = true,
		})
	end,
}
