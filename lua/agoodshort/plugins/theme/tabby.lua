return {
	"nanozuki/tabby.nvim",
	config = function()
		require("tabby.tabline").use_preset(
			"tab_only",
			{
				tab_name = {
					name_fallback = function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					end,
				},
			}
		)
		vim.cmd([[
    autocmd DirChanged * lua vim.cmd("TabRename " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~"))
]])
	end,
}
