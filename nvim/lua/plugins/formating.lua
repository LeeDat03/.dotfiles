return {
	"stevearc/conform.nvim",
	opts = {},
	lazy = true,
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
			},
			timeout = 7000,
			debug = true,
		})

		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf, async = true })
			end,
		})
	end,
}
