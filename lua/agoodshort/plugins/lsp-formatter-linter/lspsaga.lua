return {
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			vim.diagnostic.config({
				virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
				virtual_lines = { only_current_line = true },
			})
			vim.diagnostic.config({ virtual_lines = false }, require("lazy.core.config").ns) -- https://github.com/folke/lazy.nvim/issues/620
			require("lsp_lines").setup()
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
			{ "neovim/nvim-lspconfig" },
		},
		config = function()
			require("lspsaga").setup({
				preview = {
					lines_above = 5,
					lines_below = 10,
				},
				scroll_preview = {
					scroll_down = "<C-f>",
					scroll_up = "<C-b>",
				},
				request_timeout = 2000,
				finder = {
					--percentage
					max_height = 0.5,
					keys = {
						jump_to = "p",
						edit = { "o", "<CR>" },
						vsplit = "s",
						split = "i",
						tabe = "t",
						tabnew = "r",
						quit = { "q", "<ESC>", "<C-c>" },
						close_in_preview = "<ESC>",
					},
				},
				definition = {
					edit = "<C-c>o",
					vsplit = "<C-c>v",
					split = "<C-c>i",
					tabe = "<C-c>t",
					quit = "q",
					close = "<Esc>",
					back = "<C-c>b",
					next = "<C-c>n",
				},
				code_action = {
					num_shortcut = true,
					show_server_name = true,
					extend_gitsigns = true,
					keys = {
						-- string | table type
						quit = { "q", "<ESC>", "<C-c>" },
						exec = "<CR>",
					},
				},
				lightbulb = {
					enable = false,
					enable_in_insert = true,
					sign = false,
					sign_priority = 40,
					virtual_text = true,
				},
				diagnostic = {
					on_insert = true,
					on_insert_follow = false,
					insert_winblend = 0,
					show_code_action = true,
					show_source = true,
					jump_num_shortcut = true,
					--1 is max
					max_width = 0.7,
					custom_fix = nil,
					custom_msg = nil,
					text_hl_follow = false,
					border_follow = true,
					keys = {
						exec_action = "o",
						quit = "q",
						go_action = "g",
					},
				},
				rename = {
					quit = "<C-c>",
					exec = "<CR>",
					mark = "x",
					confirm = "<CR>",
					in_select = true,
				},
				outline = {
					win_position = "right",
					win_with = "",
					win_width = 30,
					show_detail = true,
					auto_preview = true,
					auto_refresh = true,
					auto_close = true,
					custom_sort = nil,
					keys = {
						jump = "o",
						expand_collapse = "u",
						quit = "q",
					},
				},
				callhierarchy = {
					show_detail = false,
					keys = {
						edit = "e",
						vsplit = "s",
						split = "i",
						tabe = "t",
						jump = "o",
						quit = "q",
						expand_collapse = "u",
					},
				},
				symbol_in_winbar = {
					enable = true,
					separator = " ",
					ignore_patterns = {},
					hide_keyword = true,
					show_file = false,
					-- folder_level = 2,
					respect_root = true,
					color_mode = true,
				},
				beacon = {
					enable = true,
					frequency = 7,
				},
				ui = {
					-- This option only works in Neovim 0.9
					title = true,
					-- Border type can be single, double, rounded, solid, shadow.
					border = "single",
					winblend = 0,
					expand = "",
					collapse = "",
					code_action = "💡",
					incoming = " ",
					outgoing = " ",
					hover = " ",
					kind = {},
				},
			})
		end,
	},
}
