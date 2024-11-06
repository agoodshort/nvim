-- Used to configure keymaps
-- Can be listed through telescope
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		{
			"echasnovski/mini.icons",
			version = false,
			opts = {},
		},
		"nvim-tree/nvim-web-devicons",
	},
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

		local blank_opts = {
			mode = "n",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		-- ####################################################################
		-- Default keymaps

		-- Toggle Search Highlight
		wk.add({
			{
				"<leader>/",
				"<cmd>:noh<cr>",
				desc = "Clear Search Highlight",
			},
			{
				"<leader>N",
				function()
					vim.o.relativenumber = not vim.o.relativenumber
				end,
				desc = "Toggle Relative Numbers",
			},
		})

		-- Spelling
		wk.add({
			"<leader>z",
			function()
				vim.o.spell = not vim.o.spell
			end,
			desc = "Toggle Spell Check",
		})

		-- Yank/paste
		wk.add({
			mode = { "n", "v" },
			{ "<leader>y", '"+y', desc = "Yank to System Clipboard" },
			{ "<leader>p", '"+p', desc = "Paste from System Clipboard" },
		})

		wk.add({
			mode = { "n", "v" },
			{ "<leader><leader>d", '"_dd', desc = "Delete using Void Buffer" },
			{ "<leader><leader>p", '"_dP', desc = "Paste and Delete using Void Buffer" },
		})

		-- Windows
		wk.add({
			{
				"<C-w>",
				group = "Windows",
			},
			{
				"<C-w>n",
				"<cmd>vsplit<cr>",
				desc = "Open New Window vertically",
			},
			{
				"<C-w>x",
				"<C-w>c",
				desc = "Close Current Window",
			},
		})

		-- Buffers
		wk.add({
			{
				"<C-h>",
				"<cmd>bprevious<cr>",
				desc = "Previous buffer",
			},
			{
				"<C-l>",
				"<cmd>bnext<cr>",
				desc = "Next buffer",
			},
		})

		-- Create line and stay at same position
		wk.add({
			{
				"<leader>o",
				"mzo<ESC>`z",
				desc = "Create line below",
			},
			{
				"<leader>O",
				"mzO<ESC>`z",
				desc = "Create line above",
			},
		})

		-- Move highlighted text
		wk.add({
			mode = { "v" },
			{
				"J",
				":m '>+1<cr>gv=gv",
				desc = "Move Text to Next line",
			},
			{ "K", ":m '<-2<cr>gv=gv", desc = "Move Text to Previous line" },
		})

		-- Quickfix
		wk.add({
			{ "[q", "<cmd>QNext<cr>", desc = "Previous Quickfix" },
			{ "]q", "<cmd>QPrev<cr>", desc = "Next Quickfix" },
			{ "<leader>q", group = "Quickfix" },
			{ "<leader>qq", "<cmd>QFToggle<cr>", desc = "Toggle Quickfix" },
			{ "<leader>ql", "<cmd>LLToggle<cr>", desc = "Toggle Loclist" },
			{ "<leader>qd", "<cmd>Reject<cr>", desc = "Remove Item From Quickfix" },
			{
				"<leader>qc",
				":cdo ",
				desc = "Do for all ",
				buffer = nil,
				silent = false, -- silent = false makes the command line appear
				noremap = true,
				nowait = false,
			},
		})

		-- Scroll down
		wk.add({
			mode = { "n", "v", "i" },
			{
				"<c-s>",
				"<c-e>",
				desc = "Scroll down",
			},
		})

		-- Escape
		wk.add({
			mode = { "n", "v", "i" },
			{
				"<c-c>",
				"<esc>",
				desc = "Escape",
			},
		})

		-- ####################################################################
		-- Plugins

		-- Telescope
		wk.register({
			bb = { "<cmd>Telescope scope buffers initial_mode=normal<cr>", "All Buffers" },
			n = {
				name = "Node Packages",
				n = { "<cmd>Telescope node_modules list<cr>", "List Node Modules" },
				N = { "<cmd>Telescope package_info<cr>", "Package Info" },
				i = { "<cmd>Telescope import<cr>", "Package import" },
			},
			f = {
				name = "Telescope",
				i = { "<cmd>IconPickerYank<cr>", "Icons Picker" },
				e = { "<cmd>Telescope env<cr>", "List Environment Variables" },
				a = { "<cmd>Telescope lazy<cr>", "List Lazy plugins" },
				c = { "<cmd>Telescope neoclip<cr>", "List Clipboard" },
				f = { "<cmd>Telescope find_files hidden=true<cr>", "Find Files" },
				h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
				k = { "<cmd>Telescope keymaps<cr>", "List Keymaps" },
				l = { "<cmd>Telescope live_grep custom_hidden=true<cr>", "Live Grep (inc. hidden, exc. .git)" },
				ll = { "<cmd>Telescope live_grep_args<cr>", "Live Grep Args" },
				s = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest" },
				u = { "<cmd>Telescope undo<cr>", "Visualize Undo Tree" },
				z = { "<cmd>Telescope zoxide list<cr>", "List z" },
				["?"] = { "<cmd>Telescope find_pickers<cr>", "List Telescope Pickers" },
			},
		}, leader_opts)

		wk.register({
			fl = {
				"\"zy<cmd>exec 'Telescope live_grep custom_hidden=true default_text=' . escape(@z, ' ')<cr>",
				"Live Grep Current Selection (inc. hidden, exc. .git)",
			},
			fll = {
				"\"zy<cmd>exec 'Telescope live_grep_args default_text=' . escape(@z, ' ')<cr>",
				"Live Grep Args Current Selection",
			},
		}, leader_opts_visual)

		wk.register({ ["<C-p>"] = { "<cmd>Telescope keymaps<cr>", "List Keymaps" } }, blank_opts)

		-- Git
		wk.register({
			g = {
				name = "Git Tools", -- optional name
				F = { "<cmd>Telescope git_files<cr>", "Telescope Git Files" },
				f = { "<cmd>DiffviewFileHistory --base=LOCAL %<cr>", "Diffview File History" },
				p = { "<cmd>DiffviewOpen origin/HEAD<cr>", "Diffview Project Origin" },
				c = { "<cmd>Telescope git_commits<cr>", "Telescope Git Commits" },
				g = { "<cmd>Telescope git_submodules<cr>", "LazyGit" },
				b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Gitsigns Blame" },
				d = { "<cmd>Telescope git_diffs diff_commits<cr>", "Diffview" },
			},
		}, leader_opts)

		wk.register({
			["]g"] = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Git Hunk" },
			["[g"] = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Previous Git Hunk" },
		}, blank_opts)

		-- Hop manual keymap register
		wk.register({
			f = { "<cmd>HopChar1CurrentLineAC<cr>", "Hop Current Line After" },
			F = { "<cmd>HopChar1CurrentLineBC<cr>", "Hop Current Line Before" },
		}, blank_opts)

		wk.register({
			h = { "<cmd>HopChar1AC<cr>", "Hop After" },
			H = { "<cmd>HopChar1BC<cr>", "Hop Before" },
		}, leader_opts)

		wk.register({
			h = { "<cmd>HopChar2MW<cr>", "Hop Anywhere" },
		}, leader2_opts)

		-- LSP
		wk.register({
			l = {
				name = "LSP",
				c = { "<cmd>Lspsaga code_action<cr>", "Lspsaga Code Action" },
				f = { "<cmd>Lspsaga finder<cr>", "Lspsaga Definition Finder" },
				v = {
					function()
						local config = vim.diagnostic.config()
						if config.virtual_text == true then
							vim.diagnostic.config({
								virtual_text = false,
							})
						else
							vim.diagnostic.config({
								virtual_text = true,
							})
						end
					end,
					"Toggle LSP Virtual Text",
				},
				o = { "<cmd>Lspsaga outline<cr>", "Lspsaga Outline" },
				r = { "<cmd>Lspsaga rename<cr>", "Lspsaga Rename" },
				h = { "<cmd>InlayHintToggle<cr>", "Toggle LSP Inlay Hint" },
				d = {
					name = "Diagnostics",
					l = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Lspsaga Show Line Diagnostics" },
					b = { "<cmd>Lspsaga show_buf_diagnostics<cr>", "Lspsaga Show Buffer Diagnostics" },
					w = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Lspsaga Show Workspace Diagnostics" },
				},
			},
		}, leader_opts)

		wk.register({
			g = {
				d = { "<cmd>Lspsaga goto_definition<cr>", "Lspsaga Go to Definition" },
				D = { "<cmd>Lspsaga peek_definition<cr>", "Lspsaga Peek Definition" },
				t = { "<cmd>Lspsaga goto_type_definition<cr>", "Lspsaga Go To Type Definition" },
				T = { "<cmd>Lspsaga peek_type_definition<cr>", "Lspsaga Peek Type Definition" },
			},
			K = { "<cmd>Lspsaga hover_doc<cr>", "Lspsaga Hover Doc" },
			["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Lspsaga Diagnostic Jump Prev" },
			["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Lspsaga Diagnostic Jump Next" },
		}, blank_opts)

		-- Crates.nvim
		wk.register({
			c = {
				name = "Crates",
				s = { "<cmd>lua require('crates').toggle()<cr>", "Show Crates virtual lines" },
				v = { "<cmd>lua require('crates').show_versions_popup()<cr>", "Show Crates versions" },
				f = { "<cmd>lua require('crates').show_features_popup()<cr>", "Show Crates features" },
				d = { "<cmd>lua require('crates').show_dependencies_popup()<cr>", "Show Crates dependencies" },
				u = { "<cmd>lua require('crates').update_crate()<cr>", "Update crate" },
				a = { "<cmd>lua require('crates').update_all_crates()<cr>", "Update All Crates" },
				x = {
					"<cmd>lua require('crates').expand_plain_crate_to_inline_table()<cr>",
					"Expand Plain Crate To Inline Table",
				},
				H = { "<cmd>lua require('crates').open_homepage()<cr>", "Open Crate Homepage" },
				R = { "<cmd>lua require('crates').open_repository()<cr>", "Open Crate Repository" },
				D = { "<cmd>lua require('crates').open_documentation()<cr>", "Open Crate Documentation" },
				C = { "<cmd>lua require('crates').open_crates_io()<cr>", "Open Crates.io" },
				i = { "<cmd>PackageInfoInstall<cr>", "Install NPM Package" },
			},
		}, leader_opts)

		-- Could not add directly into plugin config
		wk.add({
			{ "<leader>m", group = "Markdown" },
			{
				"<leader><leader>f",
				group = "Fun",
			},
			{
				"<leader><leader>fr",
				"<cmd>CellularAutomaton make_it_rain<cr>",
				desc = "Make It Rain",
			},
			{
				"<leader><leader>fh",
				"<cmd>HackFollow<cr>",
				desc = "Hack This File",
			},
		})

		wk.setup({
			preset = "modern",
		})
	end,
}
