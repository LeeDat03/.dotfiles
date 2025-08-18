return {
	{
		"stevearc/conform.nvim",
		opts = {},
		lazy = true,
		event = "BufWritePre",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "gofmt" },
					html = { "prettierd" },
					css = { "prettierd" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					javascriptreact = { "prettierd" },
					scss = { "prettierd" },
					svelte = { "prettierd" },
					jsx = { "prettierd" },
					tsx = { "prettierd" },
					json = { "prettierd" },
					sql = { "sqlfmt" },
				},
				timeout = 7000,
				debug = true,
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf, async = true })
				end,
			})
		end,
	},
}
