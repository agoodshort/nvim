return {
	"samjwill/nvim-unception",
	init = function()
		vim.g.unception_open_buffer_in_new_tab = true
		vim.cmd([[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]])

		vim.api.nvim_create_autocmd("User", {
			pattern = "UnceptionEditRequestReceived",
			callback = function()
				-- Toggle the terminal off.
				vim.cmd("9ToggleTerm")
			end,
		})
	end,
}
