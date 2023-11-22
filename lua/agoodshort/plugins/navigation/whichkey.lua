-- Used to configure keymaps
-- Can be listed through telescope
return {
	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

		-- Which-key leader config
		local leader_opts = {
			mode = "n", -- NORMAL mode
			-- prefix: use "<Leader>f" for example to map everything related to finding files
			-- the prefix is prepended to every mapping part of `mappings`
			prefix = "<Leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
		}

		local leader_opts_visual = {
			mode = "v",
			prefix = "<Leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local leader2_opts = {
			mode = "n",
			prefix = "<Leader><Leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local leader2_opts_visual = {
			mode = "v",
			prefix = "<Leader><Leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local blank_opts = {
			mode = "n",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local blank_opts_visual = {
			mode = "v",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local blank_opts_insert = {
			mode = "i",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		-- ####################################################################
		-- Default keymaps

		-- Toggle
		wk.register({
			["+"] = { "<Cmd>lua vim.lsp.buf.format()<CR>", "Format Using LSP Only" },
			["/"] = { "<Cmd>:noh<CR>", "Clear Search Highlight" },
			N = {
				function()
					vim.o.relativenumber = not vim.o.relativenumber
				end,
				"Toggle Relative Numbers",
			},
			z = {
				function()
					vim.o.spell = not vim.o.spell
				end,
				"Toggle Spell Check",
			},
		}, leader_opts)

		-- Yank/paste
		wk.register({
			y = { '"+y', "Yank to System Clipboard" },
			p = { '"+p', "Paste from System Clipboard" },
		}, leader_opts)

		wk.register({
			y = { '"+y', "Yank to System Clipboard" },
			p = { '"+p', "Paste from System Clipboard" },
		}, leader_opts_visual)

		wk.register({
			d = { '"_dd', "Delete using Void Buffer" },
			p = { '"_dP', "Paste and Delete using Void Buffer" },
		}, leader2_opts)

		wk.register({
			d = { '"_d', "Delete using Void Buffer" },
			p = { '"_dP', "Paste and Delete using Void Buffer" },
		}, leader2_opts_visual)

		-- Windows
		wk.register({
			["<C-w>"] = {
				["n"] = { "<Cmd>vsplit<CR>", "Open New Window vertically" },
				["x"] = { "<C-w>c", "Close Current Window" },
			},
		}, blank_opts)

		-- Buffers
		wk.register({
			["<C-h>"] = { "<Cmd>bprevious<CR>", "Previous buffer" },
			["<C-l>"] = { "<Cmd>bnext<CR>", "Next buffer" },
		}, blank_opts)

		-- Create line and stay at same position
		wk.register({
			["o"] = { "mzo<ESC>`z", "Create line below" },
			["O"] = { "mzO<ESC>`z", "Create line above" },
		}, leader_opts)

		-- Move highlighted text
		wk.register({
			["J"] = { ":m '>+1<CR>gv=gv", "Move Text to Next line" },
			["K"] = { ":m '<-2<CR>gv=gv", "Move Text to Previous line" },
		}, blank_opts_visual)

		-- -- Up and down centered
		-- wk.register({
		-- 	["<C-u>"] = { "<C-u>zz", "Move up centered" },
		-- 	["<C-d>"] = { "<C-d>zz", "Move down centered" },
		-- }, blank_opts)

		-- Quickfix
		wk.register({
			["[q"] = { "<Cmd>QNext<CR>", "Previous Quickfix" },
			["]q"] = { "<Cmd>QPrev<CR>", "Next Quickfix" },
		}, blank_opts)

		wk.register({
			q = {
				name = "Quickfix",
				q = { "<Cmd>QFToggle<CR>", "Toggle Quickfix" },
				l = { "<Cmd>LLToggle<CR>", "Toggle Loclist" },
				d = { "<Cmd>Reject<CR>", "Remove Item From Quickfix" },
			},
		}, leader_opts)

		wk.register({
			q = {
				name = "Quickfix",
				c = { ":cdo ", "Do For All" },
			},
		}, { mode = "n", prefix = "<Leader>", buffer = nil, silent = false, noremap = true, nowait = false }) -- silent = false makes the command line appear

		-- Escape
		wk.register({
			["<C-c>"] = { "<ESC>", "Escape" },
		}, blank_opts)
		wk.register({
			["<C-c>"] = { "<ESC>", "Escape" },
		}, blank_opts_insert)

		-- ####################################################################
		-- Plugins

		-- Neo-tree
		wk.register({
			b = { "<Cmd>Neotree toggle buffers<CR>", "Neotree Filesystem" },
			e = { "<Cmd>Neotree toggle filesystem<CR>", "Neotree Filesystem" },
			s = { "<Cmd>Neotree toggle document_symbols<CR>", "Neotree Symbols" },
		}, leader_opts)

		-- Markdown
		wk.register({
			m = {
				name = "Markdown", -- optional group name
				p = { "<Cmd>MarkdownPreview<CR>", "Preview Markdown" },
				c = { "<Cmd>FeMaco<CR>", "Fenced Code-block" },
			},
		}, leader_opts)

		-- Noice
		wk.register({
			n = {
				name = "Noice", -- optional group name
				t = { "<Cmd>Telescope noice<CR>", "Telescope History" },
				h = { "<Cmd>Noice history<CR>", "Noice History" },
				e = { "<Cmd>Noice errors<CR>", "Noice Errors" },
				l = { "<Cmd>Noice last<CR>", "Noice Last" },
			},
		}, leader2_opts)

		-- Telescope
		wk.register({
			B = { "<Cmd>Telescope scope buffers initial_mode=normal<CR>", "All Buffers" },
			bb = { "<Cmd>Telescope buffers initial_mode=normal<CR>", "Tabbed Buffers" },
			f = {
				name = "Telescope", -- optional group name
				a = { "<Cmd>Telescope lazy<CR>", "List Lazy plugins" },
				c = { "<Cmd>Telescope neoclip<CR>", "List Clipboard" },
				e = { "<Cmd>Telescope env<CR>", "List Environment Variables" },
				f = { "<Cmd>Telescope find_files hidden=true<CR>", "Find Files" },
				h = { "<Cmd>Telescope help_tags<CR>", "Help Tags" },
				i = { "<Cmd>IconPickerYank<CR>", "Icons Picker" },
				k = { "<Cmd>Telescope keymaps<CR>", "List Keymaps" },
				l = { "<Cmd>Telescope live_grep custom_hidden=true<CR>", "Live Grep (inc. hidden, exc. .git)" },
				ll = { "<Cmd>Telescope live_grep_args<CR>", "Live Grep Args" },
				n = { "<Cmd>Telescope node_modules list<CR>", "List Node Modules" },
				N = { "<Cmd>Telescope package_info<CR>", "Package Info" },
				s = { "<Cmd>Telescope grep_string<CR>", "Grep String" },
				t = { "<Cmd>Telescope http list<CR>", "List HTTP Status Code" },
				u = { "<Cmd>Telescope undo<CR>", "Visualize Undo Tree" },
				z = { "<Cmd>Telescope zoxide list<CR>", "List z" },
				["?"] = { "<Cmd>Telescope find_pickers<CR>", "List Telescope Pickers" },
			},
		}, leader_opts)

		wk.register({
			fl = {
				"\"zy<Cmd>exec 'Telescope live_grep custom_hidden=true default_text=' . escape(@z, ' ')<cr>",
				"Live Grep Current Selection (inc. hidden, exc. .git)",
			},
            fll = {
                "\"zy<Cmd>exec 'Telescope live_grep_args default_text=' . escape(@z, ' ')<cr>",
                "Live Grep Args Current Selection",
            }
		}, leader_opts_visual)

		wk.register({ ["<C-p>"] = { "<Cmd>Telescope keymaps<CR>", "List Keymaps" } }, blank_opts)

		-- Git
		wk.register({
			g = {
				name = "Git Tools", -- optional name
				F = { "<Cmd>Telescope git_files<CR>", "Telescope Git Files" },
				f = { "<Cmd>DiffviewFileHistory --base=LOCAL %<CR>", "Diffview File History" },
				c = { "<Cmd>Telescope git_commits<CR>", "Telescope Git Commits" },
				g = { "<Cmd>Telescope git_submodules<CR>", "LazyGit" },
				u = { "<Cmd>lua _GITUI_TOGGLE()<CR>", "GitUI" },
				b = { "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Gitsigns Blame" },
				d = { "<Cmd>Telescope git_diffs diff_commits<CR>", "Diffview" },
			},
		}, leader_opts)

		-- Tab Management
		wk.register({
			["<C-t>"] = {
				name = "Tabs",
				["n"] = { "<Cmd>tabnew<CR>:Dashboard<CR>", "New Tab" },
				["x"] = { "<Cmd>tabclose<CR>", "Close Tab" },
				["l"] = { "<Cmd>tabn<CR>", "Go To Right Tab" },
				["h"] = { "<Cmd>tabp<CR>", "Go To Left Tab" },
			},
		}, blank_opts)

		wk.register({
			["<C-t>"] = {
				name = "Tabs",
				["r"] = { ":TabRename ", "Rename Tab" },
			},
		}, { mode = "v", prefix = "", buffer = nil, silent = false, noremap = true, nowait = false })

		-- Toggleterm
		wk.register({
			["\\"] = { -- map to "\"
				name = "ToggleTerm",
				["\\"] = { "<Cmd>ToggleTermToggleAll<CR>", "Toggle All Terminals" },
				["1"] = { "<Cmd>1ToggleTerm<CR>", "Terminal 1" },
				["2"] = { "<Cmd>2ToggleTerm<CR>", "Terminal 2" },
				["3"] = { "<Cmd>3ToggleTerm<CR>", "Terminal 3" },
				["d"] = { "<Cmd>lua _LAZYDOCKER_TOGGLE()<CR>", "Lazydocker" },
			},
		}, leader_opts)
		wk.register({
			["\\"] = { -- map to "\"
				name = "ToggleTerm",
				["1"] = { "<Cmd>ToggleTermSendVisualLines<CR>", "Send to Terminal 1" },
				["2"] = { "<Cmd>ToggleTermSendVisualLines 2<CR>", "Send to Terminal 2" },
				["3"] = { "<Cmd>ToggleTermSendVisualLines 3<CR>", "Send to Terminal 3" },
			},
		}, leader_opts_visual)

		-- Vim-doge
		wk.register({
			d = { "<Cmd>DogeGenerate<CR>", "Generate Documentation" },
		}, leader_opts)

		-- Incline
		wk.register({
			i = { "<Cmd>lua require('incline').toggle()<CR>", "Toggle Incline" },
		}, leader_opts)

		-- Hop manual keymap register
		wk.register({
			f = { "<Cmd>HopChar1CurrentLineAC<CR>", "Hop Current Line After" },
			F = { "<Cmd>HopChar1CurrentLineBC<CR>", "Hop Current Line Before" },
		}, blank_opts)

		wk.register({
			h = { "<Cmd>HopChar1AC<CR>", "Hop After" },
			H = { "<Cmd>HopChar1BC<CR>", "Hop Before" },
		}, leader_opts)

		wk.register({
			h = { "<Cmd>HopChar2MW<CR>", "Hop Anywhere" },
		}, leader2_opts)

		-- LSP
		wk.register({
			l = {
				name = "LSP",
				c = { "<Cmd>Lspsaga code_action<CR>", "Lspsaga Code Action" },
				f = { "<Cmd>Lspsaga finder<CR>", "Lspsaga Definition Finder" },
				v = { "<Cmd>lua require('lsp_lines').toggle()<CR>", "Toggle LSP Virtual Text" },
				o = { "<Cmd>Lspsaga outline<CR>", "Lspsaga Outline" },
				r = { "<Cmd>Lspsaga rename<CR>", "Lspsaga Rename" },
				d = {
					name = "Diagnostics",
					c = { "<Cmd>Lspsaga show_cursor_diagnostics<CR>", "Lspsaga Show Cursor Diagnostics" },
					l = { "<Cmd>Lspsaga show_line_diagnostics<CR>", "Lspsaga Show Line Diagnostics" },
					b = { "<Cmd>Lspsaga show_buf_diagnostics<CR>", "Lspsaga Show Buffer Diagnostics" },
					w = { "<Cmd>Lspsaga show_workspace_diagnostics<CR>", "Lspsaga Show Workspace Diagnostics" },
				},
			},
		}, leader_opts)

		wk.register({
			g = {
				d = { "<Cmd>Lspsaga goto_definition<CR>", "Lspsaga Go to Definition" },
				D = { "<Cmd>Lspsaga peek_definition<CR>", "Lspsaga Peek Definition" },
				t = { "<Cmd>Lspsaga goto_type_definition<CR>", "Lspsaga Go To Type Definition" },
				T = { "<Cmd>Lspsaga peek_type_definition<CR>", "Lspsaga Peek Type Definition" },
			},
			K = { "<Cmd>Lspsaga hover_doc<CR>", "Lspsaga Hover Doc" },
		}, blank_opts)

		-- Guard.nvim
		wk.register({
			["="] = { "<Cmd>GuardFmt<CR>", "Format Using guard.nvim" },
		}, leader_opts)

		-- Undotree
		wk.register({
			["u"] = { "<Cmd>UndotreeToggle<CR>", "Undotree" },
		}, leader_opts)

		-- Codeium
		wk.register({
			["<C-l>"] = { "<Cmd>call codeium#CycleCompletions(1)<CR>", "Codeium next" },
			["<C-h>"] = { "<Cmd>call codeium#CycleCompletions(-1)<CR>", "Codeium previous" },
			["<S-Tab>"] = { "<Cmd>call codeium#Clear()<CR>", "Codeium clear" },
		}, blank_opts_insert)

		-- NPM Package Info
		wk.register({
			n = {
				name = "NPM Package Info",
				s = { "<Cmd>lua require('package-info').toggle()<CR>", "Show" },
				d = { "<Cmd>PackageInfoDelete<CR>", "Delete" },
				v = { "<Cmd>PackageInfoChangeVersion<CR>", "Change Version" },
				i = { "<Cmd>PackageInfoInstall<CR>", "Install" },
			},
		}, leader_opts)

		-- Fun
		wk.register({
			f = {
				name = "Fun",
				h = { "<Cmd>HackFollow<CR>", "Hack This File" },
				r = { "<Cmd>CellularAutomaton make_it_rain<CR>", "Make It Rain" },
			},
		}, leader2_opts)

		-- Kiwi
		wk.register({
			w = {
				name = "Kiwi",
				w = { "<Cmd>lua require('kiwi').open_wiki_index()<CR>", "Open Wiki Index" },
				d = { "<Cmd>lua require('kiwi').open_diary_index()<CR>", "Open Diary Index" },
				n = { "<Cmd>lua require('kiwi').open_diary_new()<CR>", "Open Diary New" },
			},
		}, leader_opts)

		wk.setup()
	end,
}
