return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		theme = "hyper",
		hide = {
			statusline = true, -- hide statusline default is true
			tabline = false, -- hide the tabline
			winbar = true, -- hide winbar
		},
		config = {
			week_header = {
				enable = true,
			},
			packages = { enable = true }, -- show how many plugins neovim loaded
			project = { limit = 8, action = "edit" },
			shortcut = {
				{
					desc = "󰚰 Lazy",
					group = "@property",
					action = "Lazy",
					key = "l",
				},
				{
					desc = " Files",
					group = "Float",
					action = function()
						vim.cmd("TabRename " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~"))
						vim.cmd("Neotree position=current")
					end,
					key = "f",
				},
				{
					desc = " Dotfiles",
					group = "DiagnosticHint",
					action = function()
						vim.cmd("tcd $XDG_CONFIG_HOME")
						vim.cmd("TabRename DotFiles")
						vim.cmd("Neotree position=current")
					end,
					key = "d",
				},
				{
					desc = " Neovim",
					group = "String",
					action = function()
						vim.cmd("tcd $XDG_CONFIG_HOME/nvim")
						vim.cmd("TabRename Neovim Config")
						vim.cmd("Neotree position=current")
					end,
					key = "n",
				},
				{
					desc = "󰌵 Chezmoi",
					group = "@property",
					action = function()
						vim.cmd("tcd $XDG_DATA_HOME/chezmoi")
						vim.cmd("TabRename Chezmoi")
						vim.cmd("Neotree position=current")
					end,
					key = "c",
				},
			},
		},
	},
}
