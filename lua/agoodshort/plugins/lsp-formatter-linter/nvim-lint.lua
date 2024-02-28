return {
	"mfussenegger/nvim-lint",
	-- ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "markdown", "lua" },
	ft = { "markdown", "yaml", "json" },
	config = function()
		local filetypes = {
			markdown = { "markdownlint", "alex", "proselint", "write_good" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
		}

		-- local eslint_langs = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
		-- for _, lang in ipairs(eslint_langs) do
		-- 	filetypes[lang] = { "eslint_d" }
		-- end

		require("lint").linters_by_ft = filetypes

		-- Lint on save
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
