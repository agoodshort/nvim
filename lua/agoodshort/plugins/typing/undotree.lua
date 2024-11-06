return {
	"mbbill/undotree",
	config = function()
		vim.opt.undofile = true
		vim.g.undotree_WindowLayout = 4
		vim.g.undotree_SetFocusWhenToggle = 1

		require("which-key").add({
			"<leader>u",
			"<cmd>UndotreeToggle<cr>",
			desc = "Undotree",
		})
	end,
}
