return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>=",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			desc = "Format using conform.nvim",
		},
	},
	config = function()
		local prettier_langs = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"css",
			"scss",
			"html",
			"htmlangular",
			"json",
			"yaml",
			"cucumber",
		}

		local options = {
			notify_on_error = true,
			formatters_by_ft = {
				python = { "black" },
				lua = { "stylua" },
				bash = { "beautysh" },
				zsh = { "beautysh" },
				toml = { "taplo" },
				markdown = { "markdownlint", "markdown-toc", "prettier", "injected" },
				xml = { "xmlformat" },
				rust = { "rustfmt" }, -- Installed manually through brew
				["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" }, -- Run on filetypes that don't have a formatter, pseudo formatters from conform.nvim
				-- Causes issue with Revanista's typos
				-- ["*"] = { "codespell" }, -- Run on all filetypes
			},
			prettier = {
				command = require("conform.util").find_executable({
					"node_modules/.bin/prettier",
				}, "prettier"),
			},
		}

		for _, lang in ipairs(prettier_langs) do
			options.formatters_by_ft[lang] = { "prettier" }
		end

		require("conform").setup(options)
	end,
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
