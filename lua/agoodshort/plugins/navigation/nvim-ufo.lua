return {
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		dependencies = { "kevinhwang91/promise-async", "luukvbaal/statuscol.nvim" },
		init = function()
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.wo.foldcolumn = "1"
		end,
		config = function()
			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			-- lsp->treesitter->indent
			local ftMap = {
				vim = "indent",
				python = { "indent" },
				git = "",
			}

			local function customizeSelector(bufnr)
				local function handleFallbackException(err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(providerName, bufnr)
					else
						return require("promise").reject(err)
					end
				end

				return require("ufo")
					.getFolds("lsp", bufnr)
					:catch(function(err)
						return handleFallbackException(err, "treesitter")
					end)
					:catch(function(err)
						return handleFallbackException(err, "indent")
					end)
			end

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return ftMap[filetype] or customizeSelector
				end,
			})
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		lazy = true,
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				segments = {
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					{
						text = { " ", builtin.foldfunc, " " },
						condition = { builtin.not_empty, true, builtin.not_empty },
						click = "v:lua.ScFa",
					},
				},
			})
		end,
	},
}
