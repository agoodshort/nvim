return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
	opts = {
		auto_update = true,
		run_on_start = true,
		ensure_installed = {
			-- LSP servers
			"json-lsp",
			"lua-language-server",
			"typescript-language-server",
			"yaml-language-server",
			"marksman",
			"beautysh",
			"cfn-lint",
			"bash-language-server",

			-- Formatters
			"stylua",
			"shfmt",
			"markdownlint",
			"markdown-toc",
			"codespell",
			"xmlformatter",
			"yamlfmt",
			"taplo",

			-- Linters
			"eslint_d",
		},
	},
}
