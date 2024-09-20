-- Documentation
-- https://www.youtube.com/watch?v=Ul_WPhS2bis
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
return {
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						-- {
						-- 	id = "scopes",
						-- 	size = 0.25,
						-- },
						{
							id = "breakpoints",
							size = 0.2,
						},
						-- {
						-- 	id = "stacks",
						-- 	size = 0.2,
						-- },
						{
							id = "watches",
							size = 0.8,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 1,
						},
						-- {
						-- 	id = "console",
						-- 	size = 1,
						-- },
					},
					position = "bottom",
					size = 10,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		dependencies = "mfussenegger/nvim-dap",
		opts = {},
	},
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		config = function()
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						require("mason-registry").get_package("js-debug-adapter"):get_install_path()
							.. "/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			require("dap").adapters["chrome"] = {
				type = "executable",
				command = "node",
				args = {
					require("mason-registry").get_package("chrome-debug-adapter"):get_install_path()
						.. "/out/src/chromeDebug.js",
				},
			}

			-- see https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				require("dap").configurations[language] = {
					{
						name = "Launch file",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						name = "Launch file for Revanista Development",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
						env = { AWS_PROFILE = "development" },
					},
					{
						name = "Launch file for Revanista QA",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
						env = { AWS_PROFILE = "qa" },
					},
					{
						-- can be used with `node --inspect-wait filename.js`
						name = "Attach to process",
						type = "pwa-node",
						request = "attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						-- requires to run `flatpak run com.google.Chrome --remote-debugging-port=9222`
						name = "Attach to Chrome Browser",
						type = "chrome",
						request = "attach",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
