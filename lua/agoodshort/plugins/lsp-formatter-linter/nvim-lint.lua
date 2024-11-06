return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	keys = {
		{
			"<leaader>+",
			function()
				require("lint").try_lint()
			end,
			desc = "Run linter",
		},
	},
	config = function()
		local filetypes = {
			markdown = { "markdownlint", "alex", "proselint", "write_good" },
			ghaction = { "actionlint" },
			cfn = { "cfn_lint" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			lua = { "luacheck" },
		}

		local eslint_langs = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
		for _, lang in ipairs(eslint_langs) do
			filetypes[lang] = { "eslint_d" }
		end

		require("lint").linters_by_ft = filetypes

		require("lint").linters.yamllint.args = {
			"-c",
			"relaxed",
		}

		-- Lint on save
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
