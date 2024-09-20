-- Documentation
-- https://www.youtube.com/watch?v=Ul_WPhS2bis
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		opts = {},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = "mfussenegger/nvim-dap",
		opts = {},
	},
	{
		"mfussenegger/nvim-dap",
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
