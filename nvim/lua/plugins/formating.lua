return {
	"stevearc/conform.nvim",
	opts = {},
	lazy = true,
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
