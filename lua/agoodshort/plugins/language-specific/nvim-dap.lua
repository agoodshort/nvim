-- Documentation
-- https://www.youtube.com/watch?v=Ul_WPhS2bis
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
return {
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		dependencies = "mfussenegger/nvim-dap",
		opts = {},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("dapui").setup({
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
			})

			require("which-key").add({
				{ "<leader>d", group = "Debugger" },
				{ "<leader>df", group = "float" },
				{
					"<leader>dfr",
					function()
						require("dapui").float_element("repl", { enter = true, height = 50, width = 100 })
					end,
					desc = "Dap-ui Repl",
				},
				{
					"<leader>dfw",
					function()
						require("dapui").float_element("watches", { enter = true, height = 50, width = 100 })
					end,
					desc = "Dap-ui Watches",
				},
				{
					"<leader>dt",
					function()
						require("dapui").toggle()
					end,
					desc = "Dap-ui Toggle",
				},
				{
					"<leader>dR",
					function()
						require("dapui").open({ reset = true })
					end,
					desc = "Dap-ui Reset",
				},
				{
					"<leader>db",
					function()
						require("dap").toggle_breakpoint()
					end,
					desc = "Toggle Dap Breakpoint",
				},
				{
					"<leader>dC",
					function()
						require("dap").run_to_cursor()
					end,
					desc = "Run Dap to Cursor",
				},
				{
					"<leader>dc",
					function()
						require("dap").continue()
					end,
					desc = "Dap Continue",
				},
				{
					"<leader>dr",
					function()
						require("dap").restart()
					end,
					desc = "Dap Restart",
				},
				{
					"<leader>dl",
					function()
						require("dap").run_last()
					end,
					desc = "Dap Run Last",
				},
				{
					"<leader>dx",
					function()
						require("dap").terminate()
					end,
					desc = "Dap Terminate",
				},
				{
					"<leader>do",
					function()
						require("dap").step_over()
					end,
					desc = "Dap Step-Over",
				},
				{
					"<leader>di",
					function()
						require("dap").step_into()
					end,
					desc = "Dap Step-Into",
				},
				{
					"<leader>de",
					function()
						require("dapui").eval(nil, { enter = true })
					end,
					desc = "Dap-ui Eval",
				},
				{
					"<leader>da",
					function()
						require("dapui").elements.watches.add()
					end,
					desc = "Dap-ui Add to Watches",
					mode = { "n", "v" },
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		config = function()
			local jsDebugAdapter = {
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
			require("dap").adapters["pwa-node"] = jsDebugAdapter
			require("dap").adapters["pwa-chrome"] = jsDebugAdapter

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
						name = "Run in Chrome Browser",
						type = "pwa-chrome",
						request = "launch",
						url = "http://localhost:3000",
						cwd = vim.fn.getcwd(),
						webRoot = "${workspaceFolder}",
						runtimeExecutable = "/var/lib/flatpak/exports/bin/com.google.Chrome",
					},
					{
						-- requires to run `flatpak run com.google.Chrome --remote-debugging-port=9222`
						name = "Attach to Chrome Browser",
						type = "pwa-chrome",
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
