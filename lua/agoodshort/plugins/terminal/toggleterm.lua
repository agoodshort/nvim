return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		function _G.set_terminal_keymaps()
			local opts = { noremap = true }
			vim.api.nvim_buf_set_keymap(0, "t", "<ESC><ESC>", [[<C-\><C-n>]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		local Terminal = require("toggleterm.terminal").Terminal
		local gitui = Terminal:new({ cmd = "gitui", close_on_exit = true, hidden = true, direction = "float" })
		local lazydocker =
			Terminal:new({ cmd = "lazydocker", close_on_exit = true, hidden = true, direction = "float" })
		local serpl = Terminal:new({ cmd = "serpl", close_on_exit = true, hidden = true, direction = "float" })

		-- Custom functions
		local wk = require("which-key")
		wk.add({
			{
				"<leader>S",
				function()
					serpl.dir = vim.fn.getcwd()
					serpl:toggle()
				end,
				desc = "serpl",
			},
			{
				"<leader>\\d",
				function()
					lazydocker.dir = vim.fn.getcwd()
					lazydocker:toggle()
				end,
				desc = "Lazydocker",
			},
			{
				"<leader>gu",
				function()
					gitui.dir = vim.fn.expand("%:p:h")
					gitui:toggle()
				end,
				desc = "GitUI",
			},
		})

		wk.add({
			{
				"<leader>\\",
				group = "ToggleTerm",
			},
			{
				"<leader>\\\\",
				"<cmd>ToggleTermToggleAll<cr>",
				desc = "Toggle All Terminals",
			},
			{
				"<leader>\\1",
				"<cmd>1ToggleTerm<cr>",
				desc = "Toggle Terminal 1",
			},
			{
				"<leader>\\2",
				"<cmd>2ToggleTerm<cr>",
				desc = "Toggle Terminal 2",
			},
			{
				"<leader>\\3",
				"<cmd>3ToggleTerm<cr>",
				desc = "Toggle Terminal 3",
			},
		})
		wk.add({
			mode = "v",
			{
				"<leader>\\1",
				"<cmd>ToggleTermSendVisualSelection<cr>",
				desc = "Send to Terminal 1",
			},
			{
				"<leader>\\2",
				"<cmd>ToggleTermSendVisualSelection 2<cr>",
				desc = "Send to Terminal 2",
			},
			{
				"<leader>\\3",
				"<cmd>ToggleTermSendVisualSelection 3<cr>",
				desc = "Send to Terminal 3",
			},
		})
	end,
}
